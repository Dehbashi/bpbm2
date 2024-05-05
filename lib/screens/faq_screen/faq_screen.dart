import 'package:bpbm2/blocs/faq_bloc/faq_bloc.dart';
import 'package:bpbm2/common/constants.dart';
import 'package:bpbm2/common/screen_texts_images/faq_screen_content.dart';
import 'package:bpbm2/common/widgets/button_widget.dart';
import 'package:bpbm2/common/widgets/faq_widget.dart';
import 'package:bpbm2/screens/widgets/screen_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FaqScreen extends StatelessWidget {
  final ScrollController? scrollController;
  final Function onAboutUsTapped;
  const FaqScreen({
    super.key,
    this.scrollController,
    required this.onAboutUsTapped,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FaqBloc>(context).add(FaqStarted(context: context));
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: SingleChildScrollView(
        controller: scrollController,
        physics: defaultScrollPhysics,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                'سوالات پرتکرار',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ScreenContainerWidget(
              textWidget: const Text(
                faqText1,
                textAlign: TextAlign.justify,
              ),
              button: ButtonWidget(
                onPressed: () {
                  onAboutUsTapped(1);
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => const ContactScreen(),
                  //   ),
                  // );
                },
                text: 'تماس با ما',
              ),
              image: Image.network(faqImage1),
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
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
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
