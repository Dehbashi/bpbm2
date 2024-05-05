import 'package:flutter/material.dart';

class ProfileDrawerHeader extends StatelessWidget {
  final IconData icon;
  final String text;
  const ProfileDrawerHeader({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: 150,
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
