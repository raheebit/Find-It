import 'package:flutter/material.dart';

import '../../features/authentication/presentation/pages/forgot_password_page.dart';
import '../../features/authentication/presentation/pages/login_page.dart';
import '../../features/authentication/presentation/pages/register_page.dart';
import '../../features/reports/presentation/pages/home_page.dart';

abstract final class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const home = '/';

  static final routes = <String, WidgetBuilder>{
    login: (_) => const LoginPage(),
    register: (_) => const RegisterPage(),
    forgotPassword: (_) => const ForgotPasswordPage(),
    home: (_) => const HomePage(),
  };
}