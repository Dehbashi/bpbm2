import 'package:bloc/bloc.dart';
import 'package:bpbm2/common/custom_error_messenger.dart';
import 'package:bpbm2/common/dialogs/loading_screen.dart';
import 'package:bpbm2/data/models/order_model/order_detail_model.dart';
import 'package:bpbm2/data/models/order_model/user_order_model.dart';
import 'package:bpbm2/data/repo/user_order_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'user_order_event.dart';
part 'user_order_state.dart';

class UserOrderBloc extends Bloc<UserOrderEvent, UserOrderState> {
  final BuildContext context;
  UserOrderBloc(this.context) : super(UserOrderInitial()) {
    on<UserOrderEvent>((event, emit) async {
      if (event is UserOrderStarted) {
        LoadingScreen.instance().show(
          context: context,
          text: 'در حال بارگذاری',
        );
        await userOrderRepository.fetchUserOrderList().then((userOrders) {
          if (userOrders.isEmpty) {
            emit(
              const UserOrderEmpty(message: 'سفارشی وجود ندارد'),
            );
          } else {
            emit(UserOrderSuccess(userOrders: userOrders));
          }
          LoadingScreen.instance().hide();
        }).catchError((e) {
          LoadingScreen.instance().hide();
          emit(UserOrderFailed());
          customErrorMessenger(
            context: context,
            message: 'خطای نامشخص',
          );
        });
      }

      if (event is UserOrderDetail) {
        LoadingScreen.instance().show(
          context: context,
          text: 'در حال بارگذاری',
        );
        await userOrderRepository
            .fetchUserOrderDetail(orderId: event.orderId)
            .then((orderDetail) {
          emit(UserOrderDetailSuccess(orderDetail: orderDetail));
          LoadingScreen.instance().hide();
        }).catchError((e) {
          LoadingScreen.instance().hide();
          emit(UserOrderDetailFailed());
          customErrorMessenger(
            context: context,
            message: 'خطای نامشخص',
          );
        });
      }
    });
  }
}
