import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key, this.onPress});

  final VoidCallback? onPress;

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
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: const Text('Next',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            )),
      ),
    );
  }
}
