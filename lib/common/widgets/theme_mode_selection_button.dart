import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bpbm2/blocs/app_theme_bloc/app_theme_bloc.dart';

class ThemeModeSelectionButton extends StatelessWidget {
  const ThemeModeSelectionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeBloc, AppThemeState>(
      builder: (context, state) {
        ThemeMode? themeMode;
        if (state is AppThemeInitial) {
          themeMode = state.themeMode;
        } else if (state is AppThemeModeChanged) {
          themeMode = state.themeMode == ThemeMode.light
              ? ThemeMode.light
              : ThemeMode.dark;
        }
        return IconButton(
          onPressed: () {
            BlocProvider.of<AppThemeBloc>(context).add(AppThemeChanged());
          },
          icon: themeMode == ThemeMode.light
              ? const Icon(
                  CupertinoIcons.moon_fill,
                  size: 30,
                  color: Colors.black,
                )
              : const Icon(
                  CupertinoIcons.sun_max_fill,
                  size: 30,
                  color: Colors.white,
                ),
        );
      },
    );
  }
}