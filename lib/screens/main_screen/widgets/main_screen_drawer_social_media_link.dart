import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreenDrawerSocialMediaLink extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const MainScreenDrawerSocialMediaLink({
    super.key,
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> socialMediaLinks = [
      {
        'https://www.facebook.com/bespareshbemaco':
            FontAwesomeIcons.squareFacebook,
      },
      {
        'https://www.instagram.com/bespareshbemaco': FontAwesomeIcons.instagram,
      },
      {
        'https://www.telegram.com/bespareshbemaco': FontAwesomeIcons.telegram,
      },
      {
        'https://www.linkedin.com/bespareshbemaco': FontAwesomeIcons.linkedin,
      },
    ];

    return Column(
      children: [
        const Text(
          'ما را در شبکه های اجتماعی دنبال کنید',
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: socialMediaLinks.map((socialMediaLink) {
            return IconButton(
              onPressed: () async {
                final url = Uri.parse(socialMediaLink.keys.first);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $url';
                }
                scaffoldKey.currentState!.closeDrawer();
              },
              icon: FaIcon(
                socialMediaLink.values.first,
                size: 30,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
