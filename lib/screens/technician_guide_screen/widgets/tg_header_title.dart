import 'package:flutter/material.dart';

class TgHeaderTitle extends StatelessWidget {
  const TgHeaderTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.emoji_objects,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          'راهنمای متخصصین',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        
      ],
    );
  }
}