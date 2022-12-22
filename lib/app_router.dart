import 'package:flutter/material.dart';
import 'package:maps_app/bussiness_logic/cubit/maps/maps_cubit.dart';
import 'package:maps_app/bussiness_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:maps_app/data/repository/maps_repo.dart';
import 'package:maps_app/data/webservices/places_web_services.dart';
import 'package:maps_app/presentation/screens/map_screen.dart';
import 'package:maps_app/presentation/screens/otp_screen.dart';
import 'presentation/screens/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static const loginScreen = '/login-screen';
  static const otpScreen = '/otp-screen';
  static const mapScreen = '/map-screen';
}

class AppRouter {
  PhoneAuthCubit? phoneAuthCubit;

  AppRouter() {
    phoneAuthCubit = PhoneAuthCubit();
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: LoginScreen(),
          ),
        );
      case Routes.otpScreen:
        final phoneNumber = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: OTPScreen(phoneNumber: phoneNumber),
          ),
        );
      case Routes.mapScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => MapsCubit(MapsRepository(PlacesWebServices())),
            child: const MapScreen(),
          ),
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
