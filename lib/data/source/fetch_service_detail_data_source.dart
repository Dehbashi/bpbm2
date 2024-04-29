import 'dart:convert';

import 'package:bpbm2/data/models/service_list/service_detail_model.dart';
import 'package:bpbm2/data/models/service_list/service_exp_model.dart';
import 'package:bpbm2/data/models/service_list/service_faq_model.dart';
import 'package:http/http.dart' as http;

abstract class IFetchServiceDetailDataSource {
  Future<ServiceDetailModel> fetchServiceDetail({required int serviceId});
}

class FetchServiceDetailRemoteDataSource
    implements IFetchServiceDetailDataSource {
  @override
  Future<ServiceDetailModel> fetchServiceDetail(
      {required int serviceId}) async {
    final url = Uri.parse(
        'https://bespareshbema.com/_next/data/VluDx3cX3qOJium7r8T6N/service/$serviceId.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final mainData =
          data['pageProps']['service']['data'] as Map<String, dynamic>;
      final mainDataQuestions = mainData['faq'] as List<dynamic>;
      final serviceExp = ServiceExpModel.fromJson(mainData['data']);
      final List<ServiceFaqModel> serviceFaqs = [];
      for (var question in mainDataQuestions) {
        serviceFaqs.add(ServiceFaqModel.fromJson(question));
      }
      return ServiceDetailModel(
        serviceExp: serviceExp,
        serviceFaqs: serviceFaqs,
      );
    } else {
      throw Exception(response.statusCode);
    }
  }
}
