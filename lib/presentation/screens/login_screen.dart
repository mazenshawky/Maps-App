import 'package:flutter/material.dart';
import 'package:maps_app/app_router.dart';
import '../widgets/phone_form_field.dart';

import '../widgets/login_intro_texts.dart';
import '../widgets/my_button.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();

  final String phoneNumber = '';

  _goNext(BuildContext context) =>
      Navigator.pushNamed(context, Routes.otpScreen);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 88),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LoginIntroTexts(),
              const SizedBox(height: 110),
              PhoneFormField(phoneNumber: phoneNumber),
              const SizedBox(height: 70),
              MyButton(
                title: 'Next',
                onPress: () => _goNext(context),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
