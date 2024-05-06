import 'package:bpbm2/data/models/question_model/question_model.dart';
import 'package:bpbm2/data/models/question_model/relation_model.dart';

class QuestionService {
  final QuestionModel question;
  final RelationModel relation;
  // final String? serviceTitle;

  const QuestionService({
    required this.question,
    required this.relation,
    // required this.serviceTitle,
  });

  QuestionService.fromJson(Map<String, dynamic> json)
      : question = QuestionModel.fromJson(json['question']),
        relation = RelationModel.fromJson(json['relation']);
  // serviceTitle = json['service_title'];
}
