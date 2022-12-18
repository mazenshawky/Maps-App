import 'package:flutter/material.dart';
import 'package:maps_app/presentation/widgets/phone_form_field.dart';

import '../widgets/intro_texts.dart';
import '../widgets/next_button.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: UniqueKey(),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 88),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const IntroTexts(),
              const SizedBox(height: 110),
              PhoneFormField(phoneNumber: phoneNumber),
              const SizedBox(height: 70),
              const NextButton(),
            ],
          ),
        ),
      ),
    ));
  }
}
