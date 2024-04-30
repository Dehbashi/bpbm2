import 'package:flutter/material.dart';

class MainScreenDrawerHeader extends StatelessWidget {
  const MainScreenDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: 180,
        ),
        const Row(
          children: [
            Icon(
              Icons.bar_chart_rounded,
              color: Color(0xFF037E85),
            ),
            SizedBox(width: 20),
            Text(
              'دسته بندی خدمات',
            ),
          ],
        ),
      ],
    );
  }
}
