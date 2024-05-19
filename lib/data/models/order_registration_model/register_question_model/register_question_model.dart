import 'package:bpbm2/data/models/question_model/question_item_model.dart';
import 'package:bpbm2/data/models/question_model/question_service.dart';

class RegisterQuestionModel {
  final List<QuestionItemModel> data;
  final int id;
  final String nextRelation;
  final int number;
  final QuestionService question;
  final int relationId;
  final String title;
  final String type;
  final String questionType;

  const RegisterQuestionModel({
    required this.data,
    required this.id,
    required this.nextRelation,
    required this.number,
    required this.question,
    required this.relationId,
    required this.title,
    required this.type,
    required this.questionType,
  });

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) {
        return item.toJson();
      }).toList(),
      'id': id,
      'next_relation': nextRelation,
      'number': number,
      'question': question.toJsonWithServiceTitle(),
      'relation_id': relationId,
      'title': title,
      'type': type,
      'typequestion': questionType,
    };
  }
}
