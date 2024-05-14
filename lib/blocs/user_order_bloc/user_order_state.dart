part of 'user_order_bloc.dart';

sealed class UserOrderState extends Equatable {
  const UserOrderState();

  @override
  List<Object> get props => [];
}

final class UserOrderInitial extends UserOrderState {}

class UserOrderSuccess extends UserOrderState {
  final List<UserOrderModel> userOrders;

  const UserOrderSuccess({
    required this.userOrders,
  });

  @override
  List<Object> get props => [
        userOrders,
      ];
}

class UserOrderFailed extends UserOrderState {}

class UserOrderEmpty extends UserOrderState {
  final String message;

  const UserOrderEmpty({required this.message});

  @override
  List<Object> get props => [message];
}

class UserOrderDetailSuccess extends UserOrderState {
  final OrderDetailModel orderDetail;

  const UserOrderDetailSuccess({required this.orderDetail});

  @override
  List<Object> get props => [orderDetail];
}

class UserOrderDetailFailed extends UserOrderState {}
