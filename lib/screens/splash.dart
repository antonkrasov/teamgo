import 'package:flutter/material.dart';
import 'package:teamgo/styles/text.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'Go',
          style: TeamGoTextStyles.splash,
        ),
      ),
    );
  }
}
