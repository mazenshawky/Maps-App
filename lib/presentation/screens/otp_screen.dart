import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../app_router.dart';
import '../../bussiness_logic/cubit/phone_auth/phone_auth_cubit.dart';
import '../../constants/app_colors.dart';
import '../widgets/constants.dart';
import '../widgets/my_button.dart';
import '../widgets/otp_intro_texts.dart';

// ignore: must_be_immutable
class OTPScreen extends StatelessWidget {
  OTPScreen({super.key, required this.phoneNumber});

  // ignore: prefer_typing_uninitialized_variables
  final phoneNumber;

  final GlobalKey<FormState> _otpFormKey = GlobalKey();

  String otpCode = '';

  _login(BuildContext context) {
    if (_otpFormKey.currentState!.validate()) {
      BlocProvider.of<PhoneAuthCubit>(context).submitOTP(otpCode);
    }
  }

  Widget _buildPhoneVerificationBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: ((previous, current) => previous != current),
      listener: (context, state) {
        if (state is Loading) {
          Constants.showProgressIndicator(context);
        }
        if (state is PhoneOTPVerified) {
          Navigator.pop(context);
          Navigator.of(context).pushReplacementNamed(Routes.mapScreen);
        }
        if (state is ErrorOccurred) {
          Navigator.pop(context);
          String errorMsg = (state).errorMsg;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMsg),
              backgroundColor: AppColors.black,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: Container(),
    );
  }

  Widget _buildPinCodeFields(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      autoFocus: true,
      cursorColor: AppColors.black,
      keyboardType: TextInputType.number,
      length: 6,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your verification code!';
        } else if (value.length < 6) {
          return 'Too short for a verification code!';
        }
        return null;
      },
      obscureText: false,
      animationType: AnimationType.scale,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        borderWidth: 1,
        activeColor: AppColors.blue,
        inactiveColor: AppColors.blue,
        inactiveFillColor: AppColors.white,
        activeFillColor: AppColors.lightBlue,
        selectedColor: AppColors.blue,
        selectedFillColor: AppColors.white,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: AppColors.white,
      enableActiveFill: true,
      onCompleted: (submitedCode) {
        otpCode = submitedCode;
      },
      onChanged: (value) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.white,
      body: Form(
        key: _otpFormKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 80),
          child: Column(children: [
            OTPIntroTexts(phoneNumber: phoneNumber),
            const SizedBox(height: 88),
            _buildPinCodeFields(context),
            const SizedBox(height: 60),
            MyButton(
              title: 'Verify',
              onPress: () => _login(context),
            ),
            _buildPhoneVerificationBloc(),
          ]),
        ),
      ),
    ));
  }
}
