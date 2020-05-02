import 'package:flutter/material.dart';
import 'package:teamgo/screens/activity_details.dart';
import 'package:teamgo/screens/add_edit_activity.dart';
import 'package:teamgo/screens/home.dart';
import 'package:teamgo/screens/splash.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'splash':
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
          settings: RouteSettings(isInitialRoute: true),
        );
      case 'home':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
          settings: RouteSettings(isInitialRoute: true),
        );
      case 'add_edit_activity':
        return MaterialPageRoute(
          builder: (_) => AddEditActivityScreen(
            paramActivity: settings.arguments,
          ),
        );
      case 'activity_details':
        return MaterialPageRoute(
          builder: (_) => ActivityDetailsScreen(
            paramActivity: settings.arguments,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            );
          },
        );
    }
  }
}
