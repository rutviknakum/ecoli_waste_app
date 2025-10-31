import 'package:flutter/material.dart';
import 'router.dart';
import '../core/themes/app_theme.dart';

class WasteManagementApp extends StatelessWidget {
  const WasteManagementApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Waste Management',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRouter.home,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
