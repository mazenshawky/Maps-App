import 'package:flutter/material.dart';

import '../widgets/my_button.dart';
import '../widgets/otp_intro_texts.dart';
import '../widgets/pin_code_fields.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  final String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 80),
        child: Column(children: [
          OTPIntroTexts(phoneNumber: phoneNumber),
          const SizedBox(height: 88),
          const PinCodeFields(),
          const SizedBox(height: 60),
          const MyButton(title: 'Verify'),
        ]),
      ),
    ));
  }
}
