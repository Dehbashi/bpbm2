import 'package:bpbm2/screens/faq_screen/faq_screen.dart';
import 'package:bpbm2/screens/rules_screen/rules_screen.dart';
import 'package:bpbm2/screens/support_screen/support_screen.dart';
import 'package:bpbm2/screens/technician_guide_screen/technician_guide_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreenDrawerQuickLink extends StatelessWidget {
  final GlobalKey<NavigatorState> navKey;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function onDrawerQuickLinkTapped;

  const MainScreenDrawerQuickLink({
    super.key,
    required this.navKey,
    required this.scaffoldKey,
    required this.onDrawerQuickLinkTapped,
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> quickLinks = [
      {
        'پرسش های پرتکرار': FaqScreen(
          onAboutUsTapped: onDrawerQuickLinkTapped,
        )
      },
      {'درخواست همکاری': const TechnicianGuideScreen()},
      {'پشتیبانی': const SupportScreen()},
      {'قوانین و مقررات': const RulesScreen()},
      {'مجله بسپارش به ما': 'https://bespareshbema.com/blog'},
    ];

    return SizedBox(
      height: 220,
      child: ListView.builder(
        shrinkWrap: false,
        controller: ScrollController(),
        itemCount: quickLinks.length,
        itemBuilder: (context, index) {
          final quickLink = quickLinks[index];
          return InkWell(
            onTap: () async {
              if (index == 0) {
                onDrawerQuickLinkTapped(3);
                scaffoldKey.currentState!.closeDrawer();
              } else if (index != 4) {
                navKey.currentState!.push(
                  MaterialPageRoute(
                    builder: (context) => quickLink.values.first,
                  ),
                );
                scaffoldKey.currentState!.closeDrawer();
              } else {
                final url = Uri.parse(quickLink.values.first);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'عدم دسترسی به $url';
                }
                scaffoldKey.currentState!.closeDrawer();
              }
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 15, 10),
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  quickLink.keys.first,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
