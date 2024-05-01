import 'package:bpbm2/common/screen_texts_images/rules_screen_content.dart';
import 'package:bpbm2/common/widgets/button_widget.dart';
import 'package:bpbm2/screens/privacy_screen/privacy_screen.dart';
import 'package:bpbm2/screens/rules_screen/widgets/rules_screen_list_of_rules.dart';
import 'package:bpbm2/screens/widgets/screen_container_widget.dart';
import 'package:flutter/material.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final double screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = AppBar().preferredSize.height;
    const double bottomNavBarHeight = kBottomNavigationBarHeight;
    final double availableHeight =
        screenHeight - appBarHeight - bottomNavBarHeight;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: availableHeight,
              child: ListView.builder(
                itemCount: rules.length + 1,
                itemBuilder: (context, index) {
                  if (index <= rules.length - 1) {
                    final rule = rules[index];
                    if (index != 0) {
                      return RulesScreenListOfRules(rule: rule);
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RulesScreenListOfRules(
                            rule: rule,
                            generalRulesHeader: 'قواعد عمومی',
                            icon: Icons.security_rounded,
                          ),
                        ],
                      );
                    }
                  } else {
                    return ScreenContainerWidget(
                      textWidget: const Text(
                        rulesFooterText,
                        textAlign: TextAlign.justify,
                      ),
                      button: ButtonWidget(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const PrivacyScreen(),
                            ),
                          );
                        },
                        text: 'حریم خصوصی کاربران',
                        buttonWidth: 200,
                      ),
                    );
                    // Container(
                    //   margin: const EdgeInsets.fromLTRB(10, 15, 10, 50),
                    //   padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    //   decoration: BoxDecoration(
                    //     color: Theme.of(context).colorScheme.primary,
                    //     borderRadius: BorderRadius.circular(5),
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       const Text(
                    //         rulesFooterText,
                    //         textAlign: TextAlign.justify,
                    //       ),
                    //       const SizedBox(
                    //         height: 10,
                    //       ),
                    //       ButtonWidget(
                    //         onPressed: () {
                    //           Navigator.of(context).push(
                    //             MaterialPageRoute(
                    //               builder: (context) => const PrivacyScreen(),
                    //             ),
                    //           );
                    //         },
                    //         text: 'حریم خصوصی کاربران',
                    //         buttonWidth: 200,
                    //       ),
                    //     ],
                    //   ),
                    // );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
