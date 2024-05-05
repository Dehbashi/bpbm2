import 'dart:convert';

import 'package:bpbm2/common/constants.dart';
import 'package:bpbm2/data/models/auth_model/auth_model.dart';
import 'package:http/http.dart' as http;

abstract class IAuthDataSource {
  Future<void> sendSms({required String cellNumber});
  Future<AuthModel> verifySms({
    required String cellNumber,
    required String otpCode,
  });
}

class AuthRemoteDataSource implements IAuthDataSource {
  @override
  Future<void> sendSms({required String cellNumber}) async {
    final url = Uri.parse('$baseUrl/auth/otp-provider/send');
    final headers = {
      'Tokenpublic': 'bpbm',
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'phone_number': cellNumber,
    });
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
    } else {
      throw Exception(response.statusCode);
    }
  }

  @override
  Future<AuthModel> verifySms({
    required String cellNumber,
    required String otpCode,
  }) async {
    final url = Uri.parse('$baseUrl/auth/otp-provider/verify');
    final headers = {
      'Tokenpublic': tokenPublic,
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'phone_number': cellNumber,
      'code': otpCode,
    });
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final mainData = data['data'] as Map<String, dynamic>;
      final auth = AuthModel.fromJosn(mainData);
      return auth;
    } else {
      throw Exception(response.statusCode);
    }
  }
}
