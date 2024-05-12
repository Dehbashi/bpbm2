import 'dart:convert';

import 'package:bpbm2/common/constants.dart';
import 'package:http/http.dart' as http;

abstract class IDiscountDataSource {
  Future<void> fetchDiscount({
    required String discount,
    required int value,
  });
}

class DiscountRemoteDataSource implements IDiscountDataSource {
  @override
  Future<void> fetchDiscount({
    required String discount,
    required int value,
  }) async {
    final url = Uri.parse('$baseUrl/calculation/checkdiscount');
    final headers = {
      'Content-Type': contentType,
      'Tokenpublic': tokenPublic,
    };
    final body = jsonEncode({
      'discount': discount,
      'value': value,
    });
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('discount succeeded');
    } else {
      print('discount failed');
      throw Exception(response.statusCode);
    }
  }
}
