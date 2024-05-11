part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {
  final bool isLoading;

  const UserInitial({required this.isLoading});

  @override
  List<Object> get props => [isLoading];
}

class UserSendSmsSuccess extends UserState {
  final bool isLoading;
  final String cellNumber;

  const UserSendSmsSuccess({
    required this.isLoading,
    required this.cellNumber,
  });

  @override
  List<Object> get props => [isLoading, cellNumber];
}

class UserSendOtpSuccess extends UserState {
  final bool isLoading;

  const UserSendOtpSuccess({required this.isLoading});

  @override
  List<Object> get props => [isLoading];
}

class UserRegisterSuccess extends UserState {
  final bool isLoading;

  const UserRegisterSuccess({required this.isLoading});

  @override
  List<Object> get props => [isLoading];
}

// class UserFailed extends UserState {}
