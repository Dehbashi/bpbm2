import 'dart:convert';

import 'package:bpbm2/data/models/question_model/question_item_model.dart';
import 'package:bpbm2/data/models/question_model/question_model.dart';
import 'package:bpbm2/providers/price_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

Future<void> saveSelectedQuestion({
  required BuildContext context,
  required QuestionModel question,
  required int answerId,
  required List<TextEditingController> textEditingControllers,
  required List<QuestionModel> selectedQuestions,
  required List<double> userInputs,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final provider = Provider.of<PriceProvider>(context, listen: false);

  if (question.type == 'radio') {
    final items = question.items
        .where((element) => int.parse(element.id) == answerId)
        .toList();
    selectedQuestions.add(
      QuestionModel(
        id: question.id,
        title: question.title,
        type: question.type,
        list: question.list,
        items: items,
      ),
    );
    provider.addItem(price: items[0].price.toDouble());
  } else if (question.type == 'textbox') {
    final length = question.items.length;
    List<double> inputs = [];
    List<QuestionItemModel> items = [];
    for (int i = 0; i < length; i++) {
      if (textEditingControllers[i].text.isNotEmpty) {
        userInputs.add(double.parse(textEditingControllers[i].text.toEnglishDigit()));
        inputs.add(double.parse(textEditingControllers[i].text.toEnglishDigit()));
        final item = question.items.firstWhere(
          (element) => int.parse(element.id) == int.parse(question.items[i].id),
        );
        items.add(item);
      }
    }
    selectedQuestions.add(
      QuestionModel(
        id: question.id,
        title: question.title,
        type: question.type,
        list: question.list,
        items: items,
      ),
    );
    print(inputs);
    double textBoxPrice = 0;
    for (int i = 0; i < items.length; i++) {
      textBoxPrice = textBoxPrice + items[i].price * inputs[i];
    }
    provider.addItem(price: textBoxPrice);
  }

  List<String> selectedQuestionsJson = selectedQuestions
      .map((question) => json.encode(question.toJson()))
      .toList();
  List<String> userInputsJson =
      userInputs.map((input) => json.encode(input)).toList();

  await prefs.setStringList('selectedQuestions', selectedQuestionsJson);
  await prefs.setStringList('userInputs', userInputsJson);
}
