import 'dart:convert';

import 'package:bpbm2/common/constants.dart';
import 'package:bpbm2/common/methods/load_token.dart';
import 'package:bpbm2/data/models/order_model/order_detail_model.dart';
import 'package:bpbm2/data/models/order_model/user_order_model.dart';
import 'package:http/http.dart' as http;

abstract class IUserOrderDataSource {
  Future<List<UserOrderModel>> fetchUserOrderList();
  Future<OrderDetailModel> fetchUserOrderDetail({required int orderId});
}

class UserOrderRemoteDataSource implements IUserOrderDataSource {
  @override
  Future<List<UserOrderModel>> fetchUserOrderList() async {
    final url = Uri.parse('$baseUrl/user/order/list');
    final token = await loadToken();
    final headers = {
      'Authorization': '$tokenPrefix $token',
      'Tokenpublic': tokenPublic,
    };
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final mainData = data['data']['data'] as List<dynamic>;
      final List<UserOrderModel> userOrders = [];
      for (var item in mainData) {
        userOrders.add(UserOrderModel.fromJson(item));
      }
      return userOrders;
    } else {
      throw Exception(response.statusCode);
    }
  }

  @override
  Future<OrderDetailModel> fetchUserOrderDetail({required int orderId}) async {
    final url = Uri.parse('$baseUrl/user/order/show');
    final token = await loadToken();
    final headers = {
      'Authorization': '$tokenPrefix $token',
      'Tokenpublic': tokenPublic,
      'Content-Type': contentType,
    };
    final body = jsonEncode({
      'id': orderId,
    });
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final mainData = data['data']['data'] as Map<String, dynamic>;
      final orderDetail = OrderDetailModel.fromJson(mainData);
      return orderDetail;
    } else {
      throw Exception(response.statusCode);
    }
  }
}
