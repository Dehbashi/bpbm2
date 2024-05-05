import 'package:bpbm2/data/models/auth_model/user_model.dart';

class AuthModel {
  final String token;
  final UserModel user;

  const AuthModel({
    required this.token,
    required this.user,
  });

  AuthModel.fromJosn(Map<String, dynamic> json)
      : token = json['token'],
        user = UserModel.fromJson(json['user']);
}
