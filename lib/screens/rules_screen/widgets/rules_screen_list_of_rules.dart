import 'package:flutter/material.dart';

class RulesScreenListOfRules extends StatelessWidget {
  final String? generalRulesHeader;
  final IconData? icon;
  const RulesScreenListOfRules({
    super.key,
    required this.rule,
    this.generalRulesHeader,
    this.icon,
  });

  final Map<String, Map<String, String>> rule;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(rule.values.first.values.first),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (icon != null)
                      Icon(
                        icon,
                        size: 25,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    if (icon != null)
                      const SizedBox(
                        width: 10,
                      ),
                    Expanded(
                      child: Text(
                        rule.keys.first,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  rule.values.first.keys.first,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
          if (generalRulesHeader != null)
            const SizedBox(
              height: 10,
            ),
          if (generalRulesHeader != null)
            Text(
              generalRulesHeader!,
              style: Theme.of(context).textTheme.titleSmall,
            ),
        ],
      ),
    );
  }
}
