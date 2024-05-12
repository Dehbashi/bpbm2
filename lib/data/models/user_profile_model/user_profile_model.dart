import 'package:bpbm2/data/models/user_profile_model/profile_model.dart';

class UserProfileModel {
  final int id;
  final int orderId;
  final String cellNumber;
  final int status;
  final String? lastSeen;
  final String? createdAt;
  final String? updatedAt;
  final String name;
  final ProfileModel profile;

  const UserProfileModel({
    required this.id,
    required this.orderId,
    required this.cellNumber,
    required this.status,
    required this.lastSeen,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.profile,
  });

  UserProfileModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        orderId = json['order_id'],
        cellNumber = json['phone_number'],
        status = json['status'],
        lastSeen = json['last_seen'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        name = json['name'],
        profile = ProfileModel.fromJson(json['profile']);
}
