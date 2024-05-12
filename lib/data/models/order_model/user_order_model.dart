import 'package:bpbm2/data/models/address_model/user_address_model.dart';
import 'package:bpbm2/data/models/order_model/order_model.dart';
import 'package:bpbm2/data/models/order_model/servicer_model.dart';

class UserOrderModel {
  final int id;
  final String service;
  final int orderStatus;
  final String date;
  final UserAddressModel address;
  final ServicerModel servicer;
  final OrderModel order;

  const UserOrderModel({
    required this.id,
    required this.service,
    required this.orderStatus,
    required this.date,
    required this.address,
    required this.servicer,
    required this.order,
  });

  UserOrderModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        service = json['service'],
        orderStatus = json['order_status'],
        date = json['date'],
        address = UserAddressModel.fromJson(json['address']),
        servicer = ServicerModel.fromJson(json['servicer']),
        order = OrderModel.fromJson(json['order']);
}
