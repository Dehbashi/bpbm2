import 'package:bpbm2/data/models/question_model/question_service.dart';
import 'package:bpbm2/data/source/question_data_source.dart';

final questionRepository =
    QuestionRepository(dataSource: QuestionRemoteDataSource());

abstract class IQuestionRepository {
  Future<QuestionService> fetchFirstQuestion({required int id});
  Future<QuestionService> fetchNextQuestion({
    required int relationId,
    required int serviceId,
  });
}

class QuestionRepository implements IQuestionRepository {
  final IQuestionDataSource dataSource;

  const QuestionRepository({required this.dataSource});

  @override
  Future<QuestionService> fetchFirstQuestion({required int id}) async {
    return dataSource.fetchFirstQuestion(id: id);
  }

  @override
  Future<QuestionService> fetchNextQuestion(
      {required int relationId, required int serviceId}) async {
    return dataSource.fetchNextQuestion(
      relationId: relationId,
      serviceId: serviceId,
    );
  }
}
