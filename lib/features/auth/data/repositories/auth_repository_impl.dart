// lib/features/auth/data/repositories/auth_repository_impl.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Use the new singleton instance API from google_sign_in
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  @override
  Future<UserEntity?> register(String email, String password, String name) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print('Auth succeeded: ${userCredential.user?.uid}');

      // Firestore write
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'name': name,
        'createdAt': FieldValue.serverTimestamp(),
      });

      print('Firestore write succeeded');

      return UserEntity(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
      );
    } catch (e) {
      print('Register failed: $e');
      rethrow;
    }
  }


  @override
  Future<UserEntity?> login(String email, String password) async {
    final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return UserEntity(
      uid: userCredential.user!.uid,
      email: userCredential.user!.email!,
      name: userCredential.user!.displayName ?? '',
    );
  }

  @override
  Future<UserEntity?> loginWithGoogle() async {
    try {
      await _googleSignIn.initialize(
        serverClientId: '952524530744-g1nmdmeq4kt80o9m51ifas5eqm2umi6c.apps.googleusercontent.com',
      );
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      // The new authentication container currently exposes only idToken.
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      // Create Firebase credential using idToken (accessToken not available in current API)
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      final userDoc = _firestore.collection('users').doc(userCredential.user!.uid);
      if (!(await userDoc.get()).exists) {
        await userDoc.set({
          'uid': userCredential.user!.uid,
          'email': userCredential.user!.email,
          'name': userCredential.user!.displayName ?? '',
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      return UserEntity(
        uid: userCredential.user!.uid,
        email: userCredential.user!.email!,
        name: userCredential.user!.displayName ?? '',
      );
    } on GoogleSignInException catch (e) {
      // User cancelled, UI unavailable, or interrupted — treat as no-result
      print('GoogleSignInException during loginWithGoogle: ${e.code} ${e.toString()}');
      return null;
    } catch (e) {
      print('Google login failed: $e');
      return null;
    }
  }


  @override
  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  @override
  UserEntity? get currentUser {
    final user = _auth.currentUser;
    if (user == null) return null;
    return UserEntity(uid: user.uid, email: user.email!, name: user.displayName ?? '');
  }
}
