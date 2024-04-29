part of 'open_app_bloc.dart';

sealed class OpenAppEvent extends Equatable {
  const OpenAppEvent();

  @override
  List<Object> get props => [];
}

class OpenAppStarted extends OpenAppEvent {}

class OpenAppIntroFinished extends OpenAppEvent {}
