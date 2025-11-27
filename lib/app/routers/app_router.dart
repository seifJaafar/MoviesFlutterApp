import 'package:flutter/widgets.dart';

import '../../features/auth/presentation/onboarding_page.dart';
import '../../features/auth/presentation/login_page.dart';
import '../../features/auth/presentation/register_page.dart';
import '../../features/auth/presentation/forgot_password_page.dart';
import '../../features/auth/presentation/profile_page.dart';
import '../../features/movies/presentation/movies_home_page.dart';
class AppRouter {
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgot = '/forgot';
  static const String profile = '/profile';
  static const String moviesHome = '/movies_home';

  static final Map<String, WidgetBuilder> routes = {
    onboarding: (_) => const OnboardingPage(),
    login: (_) => const LoginPage(),
    register: (_) => const RegisterPage(),
    forgot: (_) => const ForgotPasswordPage(),
    profile: (_) => const ProfilePage(),
    moviesHome: (_) => const MoviesHomePage(),
  };
}
