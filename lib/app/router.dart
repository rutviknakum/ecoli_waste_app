// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/ewaste/presentation/ewaste_screen.dart';
import '../features/plastic/presentation/plastic_screen.dart';
import '../features/biomedical/presentation/biomedical_screen.dart';
import '../features/engimech/presentation/engimech_screen.dart';
import '../features/about/presentation/about_screen.dart';
import '../features/facilities/presentation/facilities_screen.dart';
import '../features/awareness/presentation/awareness_screen.dart';
import '../features/awards/presentation/awards_screen.dart';
import '../features/contact/presentation/contact_screen.dart';

class AppRouter {
  static const String home = '/';
  static const String ewaste = '/ewaste';
  static const String plastic = '/plastic';
  static const String biomedical = '/biomedical';
  static const String engimech = '/engimech';
  static const String about = '/about';
  static const String facilities = '/facilities';
  static const String awareness = '/awareness';
  static const String awards = '/awards';
  static const String contact = '/contact';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      // case ewaste:
      //   return MaterialPageRoute(builder: (_) => EwasteScreen());
      // case plastic:
      //   return MaterialPageRoute(builder: (_) => PlasticScreen());
      // case biomedical:
      //   return MaterialPageRoute(builder: (_) => BiomedicalScreen());
      // case engimech:
      //   return MaterialPageRoute(builder: (_) => EngimechScreen());
      // case about:
      //   return MaterialPageRoute(builder: (_) => AboutScreen());
      // case facilities:
      //   return MaterialPageRoute(builder: (_) => FacilitiesScreen());
      // case awareness:
      //   return MaterialPageRoute(builder: (_) => AwarenessScreen());
      // case awards:
      //   return MaterialPageRoute(builder: (_) => AwardsScreen());
      case contact:
        return MaterialPageRoute(builder: (_) => ContactScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Route ${settings.name} not found')),
          ),
        );
    }
  }
}
