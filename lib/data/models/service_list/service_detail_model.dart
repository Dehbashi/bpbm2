import 'package:bpbm2/data/models/service_list/service_exp_model.dart';
import 'package:bpbm2/data/models/service_list/service_faq_model.dart';

class ServiceDetailModel {
  final ServiceExpModel serviceExp;
  final List<ServiceFaqModel> serviceFaqs;

  const ServiceDetailModel({
    required this.serviceExp,
    required this.serviceFaqs,
  });

  ServiceDetailModel.fromJson(Map<String, dynamic> json)
      : serviceExp = json['data'],
        serviceFaqs = (json['faq'] as List<dynamic>).map((serviceFaq) {
          return ServiceFaqModel.fromJson(json['faq']);
        }).toList();
}
