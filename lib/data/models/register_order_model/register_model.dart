import 'package:bpbm2/data/models/address_model/address_model.dart';
import 'package:bpbm2/data/models/address_model/full_address_model.dart';
import 'package:bpbm2/data/models/question_model/question_model.dart';

class RegisterModel {
  final AddressModel address;
  final bool newAddress;
  final String cellNumber;
  final int dateId;
  final String? description;
  final String? discount;
  final String firstName;
  final String lastName;
  final List<QuestionModel> selectedQuestions;
  final int serviceId;
  final int timeId;
  final int transportationcost;

  const RegisterModel({
    required this.address,
    required this.newAddress,
    required this.cellNumber,
    required this.dateId,
    required this.description,
    required this.discount,
    required this.firstName,
    required this.lastName,
    required this.selectedQuestions,
    required this.serviceId,
    required this.timeId,
    required this.transportationcost,
  });
}
