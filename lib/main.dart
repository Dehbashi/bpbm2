import 'package:bpbm2/app_theme/app_theme.dart';
import 'package:bpbm2/blocs/app_theme_bloc/app_theme_bloc.dart';
import 'package:bpbm2/blocs/auth_bloc/auth_bloc.dart';
import 'package:bpbm2/blocs/faq_bloc/faq_bloc.dart';
import 'package:bpbm2/blocs/open_app_bloc/open_app_bloc.dart';
import 'package:bpbm2/blocs/service_detail_bloc/service_detail_bloc.dart';
import 'package:bpbm2/blocs/service_list_bloc/service_list_bloc.dart';
import 'package:bpbm2/blocs/stepper_bloc/stepper_bloc.dart';
import 'package:bpbm2/data/repo/auth_repository.dart';
import 'package:bpbm2/screens/intro_screen/intro_screen.dart';
import 'package:bpbm2/screens/main_screen/main_screen.dart';
import 'package:bpbm2/screens/service_detail_screen/detail_screens/service_detail_screen.dart';
import 'package:bpbm2/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  authRepository.loadInfo();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final bloc = AppThemeBloc(themeMode: ThemeMode.light);
            bloc.add(AppThemeStarted());
            return bloc;
          },
        ),
        BlocProvider(
          create: (context) {
            final bloc = OpenAppBloc();
            bloc.add(OpenAppStarted());
            return bloc;
          },
        ),
        BlocProvider(create: (context) => ServiceListBloc()),
        BlocProvider(create: (context) => ServiceDetailBloc()),
        BlocProvider(create: (context) => FaqBloc()),
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => StepperBloc()),
      ],
      child: BlocBuilder<AppThemeBloc, AppThemeState>(
        builder: (context, state) {
          ThemeData? theme;
          if (state is AppThemeInitial) {
            theme = state.themeMode == ThemeMode.dark
                ? AppTheme.dark().getTheme()
                : AppTheme.light().getTheme();
          } else if (state is AppThemeModeChanged) {
            theme = state.themeMode == ThemeMode.dark
                ? AppTheme.dark().getTheme()
                : AppTheme.light().getTheme();
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Besparesh Be Ma',
            theme: theme,
            home: BlocBuilder<OpenAppBloc, OpenAppState>(
              builder: (context, state) {
                if (state is OpenAppSuccess ||
                    state is OpenAppNotFirstTimeUser) {
                  return const Directionality(
                    textDirection: TextDirection.rtl,
                    child: MainScreen(),
                  );
                } else if (state is OpenAppFirstTimeUser) {
                  return const Directionality(
                    textDirection: TextDirection.rtl,
                    child: IntroScreen(),
                  );
                } else if (state is OpenAppSplashScreen) {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: SplashScreen(versionName: state.versionName),
                  );
                } else {
                  return Container();
                }
              },
            ),
            routes: {
              ServiceDetailScreen.routName: (context) =>
                  const ServiceDetailScreen(),
            },
          );
        },
      ),
    );
  }
}
