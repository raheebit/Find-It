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
      locale: const Locale('ar'),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        ); 
      },
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}
