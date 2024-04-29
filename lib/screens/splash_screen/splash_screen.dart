import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final String versionName;

  const SplashScreen({super.key, required this.versionName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
          ),
          Positioned(
            bottom: 50,
            child: Text(
              versionName,
            ),
          ),
        ],
      ),
    );
  }
}
