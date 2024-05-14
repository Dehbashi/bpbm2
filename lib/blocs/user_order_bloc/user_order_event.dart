part of 'user_order_bloc.dart';

sealed class UserOrderEvent extends Equatable {
  const UserOrderEvent();

  @override
  List<Object> get props => [];
}

class UserOrderStarted extends UserOrderEvent {}

class UserOrderDetail extends UserOrderEvent {
  final int orderId;

  const UserOrderDetail({required this.orderId});

  @override
  List<Object> get props => [orderId];
}
