import 'dart:convert';

import 'package:bpbm2/common/constants.dart';
import 'package:bpbm2/data/models/service_list/service_list_model.dart';
import 'package:http/http.dart' as http;

abstract class IFetchServiceListDataSource {
  Future<List<ServiceListModel>> fetchServiceList();
}

class FetchServiceListRemoteDataSource implements IFetchServiceListDataSource {
  @override
  Future<List<ServiceListModel>> fetchServiceList() async {
    final url = Uri.parse('$baseUrl/calculation/list');
    final headers = {
      'Tokenpublic': 'bpbm',
    };
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final mainData = data['data']['data'] as List<dynamic>;
      final List<ServiceListModel> serviceList = [];
      for (var service in mainData) {
        serviceList.add(ServiceListModel.fromJson(service));
      }
      return serviceList;
    } else {
      throw Exception(response.statusCode);
    }
  }
}
