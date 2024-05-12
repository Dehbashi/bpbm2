part of 'final_order_bloc.dart';

sealed class FinalOrderEvent extends Equatable {
  const FinalOrderEvent();

  @override
  List<Object> get props => [];
}

class FinalOrderStarted extends FinalOrderEvent {}

class RegisterDiscount extends FinalOrderEvent {
  final String discount;

  const RegisterDiscount({required this.discount});

  @override
  List<Object> get props => [discount];
}
