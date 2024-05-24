import 'package:bpbm2/data/models/faq_list/faq_model.dart';
import 'package:bpbm2/data/models/service_list/service_exp_model.dart';

class ServiceDetailModel {
  final ServiceExpModel serviceExp;
  final List<FaqModel> serviceFaqs;

  const ServiceDetailModel({
    required this.serviceExp,
    required this.serviceFaqs,
  });

  ServiceDetailModel.fromJson(Map<String, dynamic> json)
      : serviceExp = ServiceExpModel.fromJson(json['data']),
        serviceFaqs = (json['faq'] as List<dynamic>).map((serviceFaq) {
          return FaqModel.fromJson(serviceFaq);
        }).toList();
}
