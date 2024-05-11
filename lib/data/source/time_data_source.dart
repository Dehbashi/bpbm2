import 'dart:convert';

import 'package:bpbm2/common/constants.dart';
import 'package:bpbm2/data/models/time_model/time_model.dart';
import 'package:http/http.dart' as http;

abstract class ITimeDataSource {
  Future<List<TimeModel>> fetchTime();
}

class TimeRemoteDataSource implements ITimeDataSource {
  @override
  Future<List<TimeModel>> fetchTime() async {
    final url = Uri.parse('$baseUrl/calculation/date');
    final headers = {
      'Tokenpublic': tokenPublic,
      'Content-Type': contentType,
    };
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final mainData = data['data']['date'] as List<dynamic>;
      final List<TimeModel> dates = [];
      for (var item in mainData) {
        dates.add(TimeModel.fromJson(item));
      }
      return dates;
    } else {
      throw Exception(response.statusCode);
    }
  }
}
