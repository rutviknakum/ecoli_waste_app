import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'router.dart';
import '../core/themes/app_theme.dart';
import '../core/localization/app_localizations.dart';

class WasteManagementApp extends StatefulWidget {
  const WasteManagementApp({Key? key}) : super(key: key);

  @override
  State<WasteManagementApp> createState() => _WasteManagementAppState();
}

class _WasteManagementAppState extends State<WasteManagementApp> {
  Locale _locale = Locale('en');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eco Chip',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      locale: _locale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), // English
        Locale('hi', ''), // Hindi
      ],
      initialRoute: AppRouter.splash,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
