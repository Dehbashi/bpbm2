import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_theme_event.dart';
part 'app_theme_state.dart';

class AppThemeBloc extends Bloc<AppThemeEvent, AppThemeState> {
  ThemeMode themeMode;
  AppThemeBloc({required this.themeMode})
      : super(AppThemeInitial(themeMode: themeMode)) {
    on<AppThemeEvent>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (event is AppThemeStarted) {
        String? themeModeString = prefs.getString('themeMode');

        themeMode = themeModeString != null
            ? ThemeMode.values
                .firstWhere((mode) => mode.toString() == themeModeString)
            : ThemeMode.light;
        emit(AppThemeInitial(themeMode: themeMode));
      }

      if (event is AppThemeChanged) {
        themeMode =
            (themeMode == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;

        prefs.setString('themeMode', themeMode.toString());
        emit(AppThemeModeChanged(themeMode: themeMode));
      }
    });
  }
}
