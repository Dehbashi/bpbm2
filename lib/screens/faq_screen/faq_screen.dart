import 'package:bpbm2/blocs/faq_bloc/faq_bloc.dart';
import 'package:bpbm2/common/constants.dart';
import 'package:bpbm2/common/screen_texts_images/faq_screen_content.dart';
import 'package:bpbm2/common/widgets/button_widget.dart';
import 'package:bpbm2/common/widgets/faq_widget.dart';
import 'package:bpbm2/screens/contact_screen/contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FaqBloc>(context).add(FaqStarted(context: context));
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: SingleChildScrollView(
        physics: defaultScrollPhysics,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'سوالات پرتکرار',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                children: [
                  Image.network(faqImage1),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          faqText1,
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ButtonWidget(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ContactScreen(),
                              ),
                            );
                          },
                          text: 'تماس با ما',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<FaqBloc, FaqState>(
              builder: (context, state) {
                if (state is FaqFailed) {
                  return const Center(
                    child: Text('خطا در دریافت اطلاعات'),
                  );
                } else if (state is FaqSuccess) {
                  final faqs = state.faqs;
                  if (faqs.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                      child: Column(
                        children: faqs.map((faq) {
                          return FaqWidget(
                            question: faq.title,
                            answer: faq.text,
                          );
                        }).toList(),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('لیست خالی است'),
                    );
                  }
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
