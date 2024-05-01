import 'package:flutter/material.dart';

class RulesScreenListOfRules extends StatelessWidget {
  final String? generalRulesHeader;
  const RulesScreenListOfRules({
    super.key,
    required this.rule,
    this.generalRulesHeader,
  });

  final Map<String, Map<String, String>> rule;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (generalRulesHeader != null)
            Text(
              generalRulesHeader!,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            if (generalRulesHeader != null)
            const SizedBox(height: 10,),
          Image.network(rule.values.first.values.first),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rule.keys.first,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  rule.values.first.keys.first,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        height: 1.5,
                      ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
