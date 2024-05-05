part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthSendSms extends AuthEvent {
  final String cellNumber;
  final BuildContext context;

  const AuthSendSms(this.context, {required this.cellNumber});

  @override
  List<Object> get props => [cellNumber, context];
}

class AuthVerifySms extends AuthEvent {
  final String otpCode;
  final BuildContext context;

  const AuthVerifySms(this.context, {required this.otpCode});

  @override
  List<Object> get props => [otpCode, context];
}

class AuthSignOut extends AuthEvent {
  final BuildContext context;

  const AuthSignOut({required this.context});

  @override
  List<Object> get props => [context];
}
