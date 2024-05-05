import 'package:bpbm2/blocs/open_app_bloc/open_app_bloc.dart';
import 'package:bpbm2/screens/intro_screen/methods/page_view_model.dart';
import 'package:bpbm2/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  static const size = Size(25, 25);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void onDone() async {
      BlocProvider.of<OpenAppBloc>(context).add(OpenAppIntroFinished());
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Directionality(
            textDirection: TextDirection.rtl,
            child: MainScreen(),
          ),
        ),
      );
    }

    return IntroductionScreen(
      globalBackgroundColor: Theme.of(context).colorScheme.background,
      pages: [
        pageViewModel(
          context: context,
          title: 'سرویس یا خدمت مورد نظر خودتون رو انتخاب کنید',
          imgAddress: 'assets/images/intro/price2.png',
        ),
        pageViewModel(
          context: context,
          title: 'زمان و مکان درخواست سرویس خودتون را تعیین کنید',
          imgAddress: 'assets/images/intro/price3.png',
        ),
        pageViewModel(
          context: context,
          title: 'یه چای یا قهوه برای خودتون بریزید و بقیه کارها رو ...',
          imgAddress: 'assets/images/intro/price1.png',
        ),
      ],
      done: Text(
        'پایان',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      onDone: onDone,
      onSkip: onDone,
      // showBackButton: true,
      showNextButton: true,
      showSkipButton: true,
      showDoneButton: true,
      back: const Icon(Icons.arrow_back),
      next: const Icon(Icons.arrow_forward),
      skip: Text(
        'رد کردن',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      dotsDecorator: DotsDecorator(
        size: IntroScreen.size,
        activeSize: IntroScreen.size,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(15)),
        activeShape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
