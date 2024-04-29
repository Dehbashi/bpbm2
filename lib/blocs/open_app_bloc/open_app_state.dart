part of 'open_app_bloc.dart';

sealed class OpenAppState extends Equatable {
  const OpenAppState();

  @override
  List<Object> get props => [];
}

final class OpenAppInitial extends OpenAppState {}

class OpenAppFirstTimeUser extends OpenAppState {}

class OpenAppNotFirstTimeUser extends OpenAppState {}

class OpenAppSuccess extends OpenAppState {}

class OpenAppSplashScreen extends OpenAppState {
  final String versionName;

  const OpenAppSplashScreen({required this.versionName});

  @override
  List<Object> get props => [versionName];
}
