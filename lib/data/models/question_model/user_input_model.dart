import 'package:bpbm2/data/models/question_model/question_item_model.dart';

class UserInputModel {
  final QuestionItemModel item;
  final int userInput;

  const UserInputModel({
    required this.item,
    required this.userInput,
  });
}
