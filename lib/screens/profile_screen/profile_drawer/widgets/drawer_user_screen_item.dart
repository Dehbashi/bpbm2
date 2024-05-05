import 'package:flutter/material.dart';

class DrawerUserScreenItem extends StatelessWidget {
  final Function() onTap;
  final IconData icon;
  final String text;
  const DrawerUserScreenItem({
    super.key,
    required this.onTap,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 15, 10),
        child: Row(
          children: [
            Icon(
              icon,
              size: 30,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
