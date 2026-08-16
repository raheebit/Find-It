import 'package:flutter/material.dart';
import '../../features/reports/presentation/pages/home_page.dart';

abstract final class AppRoutes {
  static const home = '/';

  static final routes = <String, WidgetBuilder>{
    home: (_) => const HomePage(),
  };
}
