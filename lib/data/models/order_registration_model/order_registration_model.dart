import 'package:bpbm2/data/models/date_model/date_model.dart';
import 'package:bpbm2/data/models/order_registration_model/register_address_model.dart';
import 'package:bpbm2/data/models/order_registration_model/register_profile_model.dart';
import 'package:bpbm2/data/models/order_registration_model/register_question_model/register_question_model.dart';
import 'package:bpbm2/data/models/order_registration_model/register_service_model.dart';
import 'package:bpbm2/data/models/order_registration_model/register_time_model.dart';

class OrderRegistrationModel {
  final RegisterAddressModel address;
  final String authUser;
  final DateModel date;
  final String? details;
  final String? discount;
  final List<RegisterQuestionModel> product;
  final RegisterProfileModel profile;
  final List<RegisterQuestionModel> questions;
  final RegisterServiceModel service;
  final RegisterTimeModel time;

  const OrderRegistrationModel({
    required this.address,
    required this.authUser,
    required this.date,
    required this.details,
    required this.discount,
    required this.product,
    required this.profile,
    required this.questions,
    required this.service,
    required this.time,
  });

  Map<String, dynamic> toJson() {
    return {
      'address': address.toJson(),
      'authuser': authUser,
      'date': date.toJson(),
      'details': details ?? '',
      'discount': discount ?? '',
      'product': product.map((item) {
        return item.toJson();
      }).toList(),
      'profile': profile.toJson(),
      'question': questions.map((question) {
        return question.toJson();
      }).toList(),
      'service': service.toJson(),
      'time': time.toJson(),
    };
  }
}
