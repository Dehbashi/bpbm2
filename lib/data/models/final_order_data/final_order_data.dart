import 'package:bpbm2/data/models/address_model/address_model.dart';
import 'package:bpbm2/data/models/question_model/question_model.dart';
import 'package:bpbm2/data/models/time_model/time_model.dart';

class FinalOrderData {
  final List<QuestionModel> selectedQuestions;
  final List<int> userInputs;
  final AddressModel selectedAddress;
  final int transportationCost;
  final TimeModel selectedDate;
  final String selectedTime;
  final String timeValue;
  final int timeId;
  final String cellNumber;
  final String firstName;
  final String lastName;

  const FinalOrderData({
    required this.selectedQuestions,
    required this.userInputs,
    required this.selectedAddress,
    required this.transportationCost,
    required this.selectedDate,
    required this.selectedTime,
    required this.timeId,
    required this.timeValue,
    required this.cellNumber,
    required this.firstName,
    required this.lastName,
  });
}
