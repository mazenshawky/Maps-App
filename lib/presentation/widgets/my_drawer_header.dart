import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/bussiness_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:maps_app/constants/app_colors.dart';

class MyDrawerHeader extends StatelessWidget {
  const MyDrawerHeader({super.key, required this.phoneAuthCubit});

  final PhoneAuthCubit phoneAuthCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 64.0,
          backgroundColor: AppColors.white,
          child: CircleAvatar(
            radius: 60.0,
            backgroundImage: AssetImage('assets/images/mazen.jpeg'),
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Mazen Shawky',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        BlocProvider<PhoneAuthCubit>(
          create: (context) => phoneAuthCubit,
          child: Text(
            '${phoneAuthCubit.getLoggedInUser().phoneNumber}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
