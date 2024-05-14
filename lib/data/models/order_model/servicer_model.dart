import 'package:bpbm2/data/models/user_profile_model/user_profile_model.dart';

class ServicerModel {
  final int id;
  final int orderId;
  final int providerId;
  final int status;
  final String? createdAt;
  final String? updatedAt;
  final UserProfileModel user;

  ServicerModel({
    required this.id,
    required this.orderId,
    required this.providerId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  ServicerModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        orderId = json['order_id'] ?? 0,
        providerId = json['provider_id'] ?? 0,
        status = json['status'] ?? 0,
        createdAt = json['created_at'] ?? '',
        updatedAt = json['updated_at'] ?? '',
        user = UserProfileModel.fromJson(json['user']);
}
