import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/entities/user_entity.dart';

// Auth state held by the Notifier
class AuthState {
  final UserEntity? user;
  final bool loading;
  final String? error;

  const AuthState({this.user, this.loading = false, this.error});

  AuthState copyWith({UserEntity? user, bool? loading, String? error}) {
    return AuthState(
      user: user ?? this.user,
      loading: loading ?? this.loading,
      error: error,
    );
  }
}

class AuthNotifier extends Notifier<AuthState> {
  final AuthRepositoryImpl _repo = AuthRepositoryImpl();

  @override
  AuthState build() {
    return const AuthState();
  }

  Future<void> register(String email, String password, String name) async {
    state = state.copyWith(loading: true, error: null);
    try {
      final user = await _repo.register(email, password, name);
      state = state.copyWith(user: user, loading: false, error: null);
    } catch (e) {
      state = state.copyWith(error: e.toString(), loading: false);
    }
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(loading: true, error: null);
    try {
      final user = await _repo.login(email, password);
      state = state.copyWith(user: user, loading: false, error: null);
    } catch (e) {
      state = state.copyWith(error: e.toString(), loading: false);
    }
  }

  Future<void> loginWithGoogle() async {
    state = state.copyWith(loading: true, error: null);
    try {
      final user = await _repo.loginWithGoogle();
      state = state.copyWith(user: user, loading: false, error: null);
    } catch (e) {
      state = state.copyWith(error: e.toString(), loading: false);
    }
  }

  Future<void> logout() async {
    await _repo.logout();
    state = state.copyWith(user: null);
  }
}

final authControllerProvider = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);
