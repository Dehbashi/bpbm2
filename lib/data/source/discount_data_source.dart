import 'dart:convert';

import 'package:bpbm2/common/constants.dart';
import 'package:http/http.dart' as http;

abstract class IDiscountDataSource {
  Future<int> fetchDiscount({
    required String discount,
    required int servicePrice,
  });
}

class DiscountRemoteDataSource implements IDiscountDataSource {
  @override
  Future<int> fetchDiscount({
    required String discount,
    required int servicePrice,
  }) async {
    final url = Uri.parse('$baseUrl/calculation/checkdiscount');
    final headers = {
      'Content-Type': contentType,
      'Tokenpublic': tokenPublic,
    };
    final body = jsonEncode({
      'discount': discount,
      'value': servicePrice,
    });
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('discount succeeded');
      final data = jsonDecode(response.body);
      final discount = data['data']['value'] as int;
      return discount;
    } else {
      print('discount failed');
      throw Exception(response.statusCode);
    }
  }
}
