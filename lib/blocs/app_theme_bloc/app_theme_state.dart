part of 'app_theme_bloc.dart';

sealed class AppThemeState extends Equatable {
  const AppThemeState();

  @override
  List<Object> get props => [];
}

final class AppThemeInitial extends AppThemeState {
  final ThemeMode themeMode;

  const AppThemeInitial({
    required this.themeMode,
  });

  @override
  List<Object> get props => [themeMode];
}

class AppThemeModeChanged extends AppThemeState {
  final ThemeMode themeMode;

  const AppThemeModeChanged({
    required this.themeMode,
  });

  @override
  List<Object> get props => [themeMode];
}
