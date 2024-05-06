import 'package:bpbm2/data/models/question_model/question_item_model.dart';

class SelectedQuestionModel {
  final String title;
  final String type;
  final String list;
  final QuestionItemModel items;

  const SelectedQuestionModel({
    required this.title,
    required this.type,
    required this.list,
    required this.items,
  });
}
