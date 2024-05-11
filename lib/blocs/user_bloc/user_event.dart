part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserStarted extends UserEvent {}

class SendSms extends UserEvent {
  final String cellNumber;

  const SendSms({required this.cellNumber});

  @override
  List<Object> get props => [cellNumber];
}

class SendOtp extends UserEvent {
  final String otpCode;

  const SendOtp({required this.otpCode});

  @override
  List<Object> get props => [otpCode];
}

class ChangeCellNumber extends UserEvent {}

class ResendSms extends UserEvent {
  final String cellNumber;

  const ResendSms({required this.cellNumber});

  @override
  List<Object> get props => [cellNumber];
}

class RegisterName extends UserEvent {
  final String firstName;
  final String lastName;

  const RegisterName({
    required this.firstName,
    required this.lastName,
  });

  @override
  List<Object> get props => [
        firstName,
        lastName,
      ];
}
