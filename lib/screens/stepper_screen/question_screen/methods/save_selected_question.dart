import 'package:bpbm2/data/models/question_model/question_item_model.dart';
import 'package:bpbm2/data/models/question_model/question_model.dart';
import 'package:flutter/material.dart';

void saveSelectedQuestion({
  required QuestionModel question,
  required int answerId,
  required List<TextEditingController> textEditingControllers,
  required List<QuestionModel> selectedQuestions,
  required List<int> userInputs,
}) {
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
  } else if (question.type == 'textbox') {
    final length = question.items.length;
    List<QuestionItemModel> items = [];
    for (int i = 0; i < length; i++) {
      if (textEditingControllers[i].text.isNotEmpty) {
        userInputs.add(int.parse(textEditingControllers[i].text));
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
  }
}
