import 'package:flutter/material.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

class FindItApp extends StatelessWidget {
  const FindItApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FindIt',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
    );
  }
}
