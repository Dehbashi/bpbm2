import 'dart:convert';

import 'package:bpbm2/common/constants.dart';
import 'package:bpbm2/data/models/faq_list/faq_model.dart';
import 'package:http/http.dart' as http;

abstract class IFetchFaqDataSource {
  Future<List<FaqModel>> fetchFaqs();
}

class FetchFaqRemoteDataSource implements IFetchFaqDataSource {
  @override
  Future<List<FaqModel>> fetchFaqs() async {
    final url = Uri.parse('$baseUrl/faq/all');
    final headers = {
      'Tokenpublic': 'bpbm',
    };
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final mainData = data['data']['data'] as List<dynamic>;
      final List<FaqModel> faqs = [];
      for (var faq in mainData) {
        faqs.add(FaqModel.fromJson(faq));
      }
      return faqs;
    } else {
      throw Exception(response.statusCode);
    }
  }
}
