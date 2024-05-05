part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {
  final bool isLoading;

  const AuthInitial({required this.isLoading});

  @override
  List<Object> get props => [isLoading];
}

class SendSmsSuccess extends AuthState {
  final bool isLoading;

  const SendSmsSuccess({required this.isLoading});

  @override
  List<Object> get props => [isLoading];
}

class VerifySmsSuccess extends AuthState {
  final bool isLoading;
  final AuthModel authModel;

  const VerifySmsSuccess({
    required this.isLoading,
    required this.authModel,
  });

  @override
  List<Object> get props => [isLoading, authModel];
}

class AuthSuccess extends AuthState {
  final UserModel user;

  const AuthSuccess({required this.user});

  @override
  List<Object> get props => [user];
}
