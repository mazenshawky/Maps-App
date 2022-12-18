import 'package:flutter/material.dart';
import 'package:maps_app/presentation/screens/login_screen.dart';

class Routes {
  static const loginScreen = '/';
}

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: ((context) => const Scaffold(
              body: Center(child: Text('No Route Found!')),
            )));
  }
}
