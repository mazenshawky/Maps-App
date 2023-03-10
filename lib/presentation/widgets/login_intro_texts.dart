import 'package:flutter/material.dart';
import 'package:maps_app/constants/app_colors.dart';

class LoginIntroTexts extends StatelessWidget {
  const LoginIntroTexts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What is your phone number?',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: const Text(
            'Please enter your phone number to verify your account.',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
