import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class OTPIntroTexts extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  OTPIntroTexts({super.key, required this.phoneNumber});

  late final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Verify your phone number',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: RichText(
            text: TextSpan(
              text: 'Enter your 6 digits code number sent to ',
              style: const TextStyle(
                  color: Colors.black, fontSize: 18, height: 1.4),
              children: <TextSpan>[
                TextSpan(
                  text: phoneNumber,
                  style: const TextStyle(color: AppColors.blue),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
