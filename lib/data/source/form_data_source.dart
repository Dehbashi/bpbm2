import 'dart:convert';

import 'package:bpbm2/common/constants.dart';
import 'package:bpbm2/data/models/form_model/contact_form_model.dart';
import 'package:http/http.dart' as http;

abstract class IFormDataSource {
  Future<ContactFormModel> sendContactForm({
    required String name,
    required String cellNumber,
    required String subject,
    required String text,
  });
  Future<ContactFormModel> sendTechnicianForm({
    required String firstName,
    required String lastName,
    required String cellNumber,
    required String text,
    required String nationalId,
  });
}

class FormRemoteDataSource implements IFormDataSource {
  @override
  Future<ContactFormModel> sendContactForm({
    required String name,
    required String cellNumber,
    required String subject,
    required String text,
  }) async {
    final url = Uri.parse('$baseUrl/form/submit');
    final headers = {
      'Content-Type': contentType,
      'Tokenpublic': tokenPublic,
    };
    final body = jsonEncode({
      'form_id': '1',
      'name': name,
      'phone_number': cellNumber,
      'subject': subject,
      'text': text,
    });
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final mainData = data['data']['data'] as Map<String, dynamic>;
      final contactInfo = ContactFormModel.fromJson(mainData);
      return contactInfo;
    } else {
      throw Exception(response.statusCode);
    }
  }

  @override
  Future<ContactFormModel> sendTechnicianForm({
    required String firstName,
    required String lastName,
    required String cellNumber,
    required String text,
    required String nationalId,
  }) async {
    final url = Uri.parse('$baseUrl/form/submit');
    final headers = {
      'Content-Type': contentType,
      'Tokenpublic': tokenPublic,
    };
    final body = jsonEncode({
      'form_id': '1',
      'firstname': firstName,
      'lastname': lastName,
      'phone_number': cellNumber,
      'text': text,
      'melicode': nationalId,
    });
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final mainData = data['data']['data'] as Map<String, dynamic>;
      final contactInfo = ContactFormModel.fromJson(mainData);
      return contactInfo;
    } else {
      throw Exception(response.statusCode);
    }
  }
}
