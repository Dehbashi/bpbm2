part of 'question_bloc.dart';

sealed class QuestionState extends Equatable {
  const QuestionState();

  @override
  List<Object> get props => [];
}

final class QuestionInitial extends QuestionState {}

class QuestionSuccess extends QuestionState {
  final QuestionService questionService;

  const QuestionSuccess({required this.questionService});

  @override
  List<Object> get props => [questionService];
}

class QuestionFailed extends QuestionState {}

class QuestionFinish extends QuestionState {}
