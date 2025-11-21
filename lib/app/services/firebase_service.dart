// lib/core/services/firebase_service.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class FirebaseService {
  static bool _initialized = false;

  /// Initialize Firebase once
  static Future<void> initialize() async {
    if (_initialized) return;

    try {
      await Firebase.initializeApp(
        // If you have multiple environments or Firebase options, you can specify here:
        // options: DefaultFirebaseOptions.currentPlatform,
      );
      _initialized = true;
      if (kDebugMode) print('Firebase initialized successfully.');
    } catch (e) {
      if (kDebugMode) print('Error initializing Firebase: $e');
      rethrow;
    }
  }
}
