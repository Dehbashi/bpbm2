import 'package:flutter/material.dart';

class QuestionScreenHeader extends StatelessWidget {
  final String serviceTitle;
  const QuestionScreenHeader({super.key, required this.serviceTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'لطفا مراحل ثبت پرسشنامه رو به دقت ددنبال کنید',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Row(
            children: [
              Text(serviceTitle),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 23,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
