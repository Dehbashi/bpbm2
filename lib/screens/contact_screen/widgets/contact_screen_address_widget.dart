import 'package:bpbm2/common/screen_texts_images/contact_screen_content.dart';
import 'package:bpbm2/screens/widgets/screen_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreenAddressWidget extends StatelessWidget {
  const ContactScreenAddressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenContainerWidget(
      textWidget: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  contactAddressIcon,
                  size: 30,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'نشانی',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Text(
                contactAddress,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Icon(
                  color: Theme.of(context).colorScheme.onBackground,
                  contactEmailIcon,
                  size: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(contactEmail),
              ],
            ),
          ],
        ),
      ),
      button: InkWell(
        onTap: () async {
          final Uri phoneUri = Uri(
            scheme: 'tel',
            path: '02191077077',
          );
          if (await canLaunchUrl(phoneUri)) {
            await launchUrl(phoneUri);
          } else {}
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
          margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Column(
              children: [
                Icon(
                  Icons.call,
                  size: 40,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'تلفن بسپارش به ما',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '91077077',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}