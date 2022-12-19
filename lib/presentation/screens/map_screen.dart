import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/app_router.dart';
import 'package:maps_app/bussiness_logic/cubit/phone_auth/phone_auth_cubit.dart';

import '../widgets/my_button.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();

  _logout() async {
    phoneAuthCubit.logOut();
    Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<PhoneAuthCubit>(
        create: (context) => phoneAuthCubit,
        child: Center(
          child: MyButton(
            title: 'Logout',
            onPress: () => _logout(),
          ),
        ),
      ),
    );
  }
}
