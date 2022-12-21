import 'package:flutter/material.dart';

class MyDrawerHeader extends StatelessWidget {
  const MyDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CircleAvatar(
          radius: 64.0,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 60.0,
            backgroundImage: AssetImage('assets/images/mazen.jpeg'),
          ),
        ),
        SizedBox(height: 5),
        Text(
          'Mazen Shawky',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(
          '01205544631',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
