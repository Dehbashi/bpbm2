import 'dart:convert';

import 'package:bpbm2/data/models/address_model/address_model.dart';
import 'package:bpbm2/data/models/final_order_data/final_order_data.dart';
import 'package:bpbm2/data/models/question_model/question_model.dart';
import 'package:bpbm2/data/models/time_model/time_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<FinalOrderData> fetchFinalOrderData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String> selectedQuestionsJson =
      prefs.getStringList('selectedQuestions') ?? [];
  List<QuestionModel> selectedQuestions =
      selectedQuestionsJson.map((jsonString) {
    final data = json.decode(jsonString) as Map<String, dynamic>;
    final question = QuestionModel.fromJson(data);
    print(question);
    return QuestionModel.fromJson(json.decode(jsonString));
  }).toList();

  List<String> userInputsJson = prefs.getStringList('userInputs') ?? [];
  List<double> userInputs = userInputsJson
      .map((jsonString) {
        return json.decode(jsonString);
      })
      .toList()
      .cast<double>();

  final selectedAddressJson = prefs.getString('selectedAddress') ?? '';
  final Map<String, dynamic> addressJsonData = jsonDecode(selectedAddressJson);
  final selectedAddress = AddressModel.fromJson(addressJsonData);

  final transportationCost = prefs.getInt('transportationCost') ?? 0;

  final selectedDateJson = prefs.getString('selectedDate') ?? '';
  final Map<String, dynamic> dateJsonData = jsonDecode(selectedDateJson);
  final selectedDate = TimeModel.fromJson(dateJsonData);

  final selectedTime = prefs.getString('selectedTime') ?? '';

  final finalOrderData = FinalOrderData(
    selectedQuestions: selectedQuestions,
    userInputs: userInputs,
    selectedAddress: selectedAddress,
    transportationCost: transportationCost,
    selectedDate: selectedDate,
    selectedTime: selectedTime,
  );

  return finalOrderData;
}
