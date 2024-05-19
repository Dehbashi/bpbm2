import 'dart:convert';

import 'package:bpbm2/common/constants.dart';
import 'package:bpbm2/common/methods/load_token.dart';
import 'package:bpbm2/data/models/order_registration_model/order_registration_model.dart';
import 'package:bpbm2/data/models/register_order_model/registered_order_model.dart';
import 'package:http/http.dart' as http;

abstract class IRegisterOrderDataSource {
  Future<RegisteredOrderModel> registerOrder(
      {required OrderRegistrationModel order});
}

class RegisterOrderRemoteDataSource implements IRegisterOrderDataSource {
  @override
  Future<RegisteredOrderModel> registerOrder(
      {required OrderRegistrationModel order}) async {
    final token = await loadToken();
    final url = Uri.parse('$baseUrl/calculation/submitv2-app');
    final headers = {
      'Tokenpublic': tokenPublic,
      'Content-Type': contentType,
      'Authorization': '$tokenPrefix $token',
    };
    final body = jsonEncode(order.toJson());
    final response = await http.post(url, headers: headers, body: body);
    print(response.body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final mainData = data['data']['order'] as Map<String, dynamic>;
      final registeredOrder = RegisteredOrderModel.fromJson(mainData);
      return registeredOrder;
    } else {
      throw Exception(response.statusCode);
    }
  }
}
