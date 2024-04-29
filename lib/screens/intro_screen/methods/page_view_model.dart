import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

PageViewModel pageViewModel({
    required String title,
    required String imgAddress,
    required BuildContext context,
  }) {
    return PageViewModel(
      title: title,
      bodyWidget: const Text(''),
      image: Center(
        child: Align(
          alignment: Alignment.center,
          child: Image.asset(
            imgAddress,
            width: 258,
            height: 300,
          ),
        ),
      ),
      decoration: PageDecoration(
        safeArea: 100,
        imageAlignment: Alignment.center,
        bodyAlignment: Alignment.center,
        contentMargin: const EdgeInsets.symmetric(
          horizontal: 60,
          vertical: 100,
        ),
        bodyFlex: 2,
        imageFlex: 3,
        titleTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }