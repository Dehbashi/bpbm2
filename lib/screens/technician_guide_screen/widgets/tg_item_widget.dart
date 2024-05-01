import 'package:flutter/material.dart';

class TgItemWidget extends StatelessWidget {
  const TgItemWidget({
    super.key,
    required this.tgItem,
  });

  final Map<String, Map<String, dynamic>> tgItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                tgItem.values.first.values.first,
                size: 25,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                tgItem.keys.first,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary
                    ),
              ),
            ],
          ),
          const Divider(
            thickness: 2.5,
          ),
          Text(
            tgItem.values.first.keys.first,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}