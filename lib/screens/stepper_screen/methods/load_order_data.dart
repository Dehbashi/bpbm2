import 'dart:convert';

import 'package:bpbm2/data/models/address_model/address_model.dart';
import 'package:bpbm2/data/models/final_order_data/final_order_data.dart';
import 'package:bpbm2/data/models/question_model/question_model.dart';
import 'package:bpbm2/data/models/time_model/time_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<FinalOrderData> fetchFinalOrderData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  List<QuestionModel> questions = [];
  List<String> selectedQuestionsJson =
      prefs.getStringList('selectedQuestions') ?? [];
  for (var item in selectedQuestionsJson) {
    try {
      final data = json.decode(item) as Map<String, dynamic>;
      questions.add(QuestionModel.fromJson(data));
    } catch (e) {
      print('Error decoding JSON: $e');
    }
  }

  List<String> userInputsJson = prefs.getStringList('userInputs') ?? [];
  List<int> userInputs = userInputsJson
      .map((jsonString) {
        return json.decode(jsonString);
      })
      .toList()
      .cast<int>();

  final selectedAddressJson = prefs.getString('selectedAddress') ?? '';
  final Map<String, dynamic> addressJsonData = jsonDecode(selectedAddressJson);
  final selectedAddress = AddressModel.fromJson(addressJsonData);

  final transportationCost = prefs.getInt('transportationCost') ?? 0;

  final selectedDateJson = prefs.getString('selectedDate') ?? '';
  final Map<String, dynamic> dateJsonData = jsonDecode(selectedDateJson);
  final selectedDate = TimeModel.fromJson(dateJsonData);

  final selectedTime = prefs.getString('selectedTime') ?? '';

  final finalOrderData = FinalOrderData(
    selectedQuestions: questions,
    userInputs: userInputs,
    selectedAddress: selectedAddress,
    transportationCost: transportationCost,
    selectedDate: selectedDate,
    selectedTime: selectedTime,
  );

  return finalOrderData;
}
