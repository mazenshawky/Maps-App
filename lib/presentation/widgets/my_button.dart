import 'package:flutter/material.dart';
import 'package:maps_app/constants/app_colors.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, this.onPress, required this.title});

  final VoidCallback? onPress;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          if (onPress != null) {
            onPress!();
          }
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(110, 50),
          backgroundColor: AppColors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
