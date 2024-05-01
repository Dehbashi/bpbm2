import 'package:bpbm2/common/screen_texts_images/privacy_screen_content.dart';
import 'package:bpbm2/common/widgets/button_widget.dart';
import 'package:bpbm2/screens/rules_screen/rules_screen.dart';
import 'package:bpbm2/screens/widgets/screen_container_widget.dart';
import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.security_rounded,
                      size: 30,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        privacyHeaderText,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Image.network(privacyHeaderImage),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  privacyParagraph,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
          ScreenContainerWidget(
            textWidget: const Text(
              privacyFooter,
              textAlign: TextAlign.justify,
            ),
            button: ButtonWidget(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const RulesScreen(),
                  ),
                );
              },
              text: 'قوانین و مقررات',
            ),
          ),
        ],
      ),
    );
  }
}
