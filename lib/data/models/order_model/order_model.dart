import 'package:bpbm2/data/models/address_model/user_address_model.dart';
import 'package:bpbm2/data/models/order_model/service_model.dart';
import 'package:bpbm2/data/models/order_model/servicer_model.dart';

class OrderModel {
  final int id;
  final int orderDataId;
  final int serviceId;
  final int userId;
  final int priceServices;
  final String priceProducts;
  final String transportationCost;
  final int tax;
  final String discount;
  final String totalPrice;
  final int addressId;
  final String date;
  final String time;
  final String text;
  final int status;
  final int orderStatus;
  final int pull;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final UserAddressModel address;
  final ServiceModel service;
  final ServicerModel servicer;

  const OrderModel({
    required this.id,
    required this.orderDataId,
    required this.serviceId,
    required this.userId,
    required this.priceServices,
    required this.priceProducts,
    required this.transportationCost,
    required this.tax,
    required this.discount,
    required this.totalPrice,
    required this.addressId,
    required this.date,
    required this.time,
    required this.text,
    required this.status,
    required this.orderStatus,
    required this.pull,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.address,
    required this.service,
    required this.servicer,
  });

  OrderModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        orderDataId = json['order_data_id'],
        serviceId = json['service_id'],
        userId = json['user_id'],
        priceServices = json['price_services'],
        priceProducts = json['price_products'],
        transportationCost = json['transportationcost'],
        tax = json['tax'],
        discount = json['discount'],
        totalPrice = json['totalprice'],
        addressId = json['address_id'],
        date = json['date'],
        time = json['time'],
        text = json['text'],
        status = json['status'],
        orderStatus = json['order_status'],
        pull = json['pull'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        deletedAt = json['deleted_at'],
        address = UserAddressModel.fromJson(json['address']),
        service = ServiceModel.fromJson(json['service']),
        servicer = ServicerModel.fromJson(json['servicer']);
}
