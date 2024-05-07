import 'package:flutter/material.dart';

class AppTheme {
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecodary;
  final Color success;
  final Color neutral;
  final Color information;
  final Color information2;
  final Color warning;
  final Color error;
  final Color onError;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color deepYellow;
  final Color fiveStar;
  final Color shadowColor;

  AppTheme.light()
      : primary = const Color(0xFFCDEEF0),
        onPrimary = const Color(0xff04A8B2),
        secondary = const Color(0xffFF0D55),
        onSecodary = const Color(0xffFF0D55),
        success = const Color(0xff06C98B),
        neutral = const Color(0xffA1A5A5),
        information = const Color(0xff1385D7),
        information2 = const Color(0xff0066FF),
        warning = const Color(0xffFFA14A),
        error = const Color(0xffB10606),
        onError = Colors.white,
        background = const Color(0xffF5F7F7),
        onBackground = const Color(0xff025459),
        surface = const Color(0xffF5F7F7),
        onSurface = const Color(0xffF5F7F7),
        deepYellow = const Color(0xffFFB800),
        fiveStar = const Color(0xffFBD144),
        shadowColor = Colors.black54;

  AppTheme.dark()
      : primary = const Color(0xff04A8B2),
        onPrimary = const Color(0xff04A8B2),
        secondary = const Color(0xffFF0D55),
        onSecodary = const Color(0xffFF0D55),
        success = const Color(0xff06C98B),
        neutral = const Color(0xffA1A5A5),
        information = const Color(0xff1385D7),
        information2 = const Color(0xff0066FF),
        warning = const Color(0xffFFA14A),
        error = const Color(0xffB10606),
        onError = Colors.white,
        background = const Color(0xffF5F7F7),
        onBackground = const Color(0xffF5F7F7),
        surface = const Color(0xffF5F7F7),
        onSurface = const Color(0xffF5F7F7),
        deepYellow = const Color(0xffFFB800),
        fiveStar = const Color(0xffFBD144),
        shadowColor = Colors.black54;

  ThemeData getTheme() {
    const String defaultFontFamily = 'iransans';
    return ThemeData(
      dividerColor: onPrimary,
      fontFamily: defaultFontFamily,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: background,
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: IconThemeData(
          color: secondary,
        ),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedIconTheme: IconThemeData(
          color: onPrimary,
        ),
        selectedItemColor: secondary,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: MaterialStateProperty.all(primary),
        ),
      ),
      // textButtonTheme: TextButtonThemeData(
      //   style: ButtonStyle(
      //     foregroundColor: MaterialStateProperty.all(primaryText),
      //   ),
      // ),
      textTheme: faPrimaryTextTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      // appBarTheme: AppBarTheme(
      //   backgroundColor: primary,
      //   titleTextStyle: TextStyle(
      //     fontFamily: defaultFontFamily,
      //     fontWeight: FontWeight.bold,
      //     fontSize: 18,
      //     color: onPrimary,
      //   ),
      // ),
      // dialogTheme: DialogTheme(
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(10),
      //   ),
      //   backgroundColor: background,
      //   contentTextStyle: TextStyle(
      //     fontFamily: defaultFontFamily,
      //     color: primaryText,
      //   ),
      //   titleTextStyle: TextStyle(
      //       fontFamily: defaultFontFamily,
      //       fontWeight: FontWeight.bold,
      //       color: primaryText),
      // ),
      colorScheme: ColorScheme(
        shadow: shadowColor,
        brightness: Brightness.light,
        primary: primary,
        onPrimary: onPrimary,
        secondary: secondary,
        onSecondary: onSecodary,
        error: error,
        onError: onError,
        background: background,
        onBackground: onBackground,
        surface: surface,
        onSurface: onSurface,
        onPrimaryContainer: neutral,
        inversePrimary: warning,
        secondaryContainer: success,
      ),
    );
  }

  TextTheme get faPrimaryTextTheme => TextTheme(
        // headline 1
        headlineLarge: const TextStyle(
          fontSize: 96,
        ),
        // headline 2
        headlineMedium: const TextStyle(
          fontSize: 72,
        ),
        // headline 3
        headlineSmall: const TextStyle(
          fontSize: 48,
        ),
        // title 1
        titleLarge: const TextStyle(
          fontSize: 32,
        ),
        // title 2
        titleMedium: TextStyle(
          fontSize: 24,
          color: onBackground,
          fontWeight: FontWeight.bold,
        ),
        // title 3
        titleSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: onBackground,
        ),
        // body 1
        bodyLarge: TextStyle(
          fontSize: 18,
          color: onBackground,
        ),
        // body 2
        bodyMedium: TextStyle(
          fontSize: 16,
          color: onBackground,
          height: 1.7,
        ),
        // body 3
        bodySmall: TextStyle(
          fontSize: 14,
          color: onBackground,
        ),
        // caption 1
        labelLarge: const TextStyle(
          fontSize: 12,
        ),
        // caption 2
        labelMedium: const TextStyle(
          fontSize: 11,
        ),
        // caption 3
        labelSmall: TextStyle(fontSize: 10, color: onBackground),
      );
}
