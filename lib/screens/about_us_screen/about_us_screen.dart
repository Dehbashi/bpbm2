import 'package:bpbm2/common/screen_texts_images/about_us_screen_content.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  final ScrollController scrollController;

  const AboutUsScreen(
      {super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: ListView.builder(
        controller: scrollController,
        itemCount: aboutUsContent.length,
        itemBuilder: (context, index) {
          final aboutUs = aboutUsContent[index];
          if (index < 2) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(aboutUs.values.first.keys.first),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    aboutUs.keys.first,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    aboutUs.values.first.values.first,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            );
          } else if (index == 2) {
            return Column(
              children: [
                Text(
                  aboutUs.keys.first,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(aboutUs.values.first.keys.first),
                ),
              ],
            );
          } else {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    aboutUs.values.first.keys.first,
                    width: 50,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    aboutUs.keys.first,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    aboutUs.values.first.values.first,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
