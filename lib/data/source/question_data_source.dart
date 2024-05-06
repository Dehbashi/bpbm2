import 'dart:convert';

import 'package:bpbm2/common/constants.dart';
import 'package:bpbm2/data/models/question_model/question_service.dart';
import 'package:http/http.dart' as http;

abstract class IQuestionDataSource {
  Future<QuestionService> fetchFirstQuestion({required int id});
  Future<QuestionService> fetchNextQuestion({
    required int relationId,
    required int serviceId,
  });
}

class QuestionRemoteDataSource implements IQuestionDataSource {
  @override
  Future<QuestionService> fetchFirstQuestion({required int id}) async {
    final url = Uri.parse('$baseUrl/calculation/select_service');
    final headers = {
      'Tokenpublic': tokenPublic,
      'Content-Type': contentType,
    };
    final body = jsonEncode({'service_id': id});
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final mainData = data['data'] as Map<String, dynamic>;
      final firstQuestion = QuestionService.fromJson(mainData);
      return firstQuestion;
    } else {
      throw Exception(response.statusCode);
    }
  }

  @override
  Future<QuestionService> fetchNextQuestion(
      {required int relationId, required int serviceId}) async {
    final url = Uri.parse('$baseUrl/calculation/question');
    final headers = {
      'Tokenpublic': tokenPublic,
      'Content-Type': contentType,
    };
    final body = jsonEncode({
      'relation_id': relationId,
      'service_id': serviceId,
    });
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final mainData = data['data'];
      final nextQuestion = QuestionService.fromJson(mainData);
      return nextQuestion;
    } else {
      throw Exception(response.statusCode);
    }
  }
}
