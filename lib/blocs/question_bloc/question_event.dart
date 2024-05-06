part of 'question_bloc.dart';

sealed class QuestionEvent extends Equatable {
  const QuestionEvent();

  @override
  List<Object> get props => [];
}

class QuestionStarted extends QuestionEvent {
  final int serviceId;
  final BuildContext context;

  const QuestionStarted({
    required this.serviceId,
    required this.context,
  });

  @override
  List<Object> get props => [serviceId, context];
}

class NextQuestionRequest extends QuestionEvent {
  final int serviceId;
  final int nextRelation;
  final BuildContext context;

  const NextQuestionRequest({
    required this.serviceId,
    required this.nextRelation,
    required this.context,
  });

  @override
  List<Object> get props => [
        serviceId,
        nextRelation,
        context,
      ];
}
