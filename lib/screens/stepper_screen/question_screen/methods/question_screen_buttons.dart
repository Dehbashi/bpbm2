import 'package:bpbm2/blocs/question_bloc/question_bloc.dart';
import 'package:bpbm2/blocs/stepper_bloc/stepper_bloc.dart';
import 'package:bpbm2/common/widgets/elevated_icon_widget.dart';
import 'package:bpbm2/data/models/question_model/question_model.dart';
import 'package:bpbm2/screens/stepper_screen/question_screen/methods/save_selected_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionScreenButtons extends StatefulWidget {
  final List<int> relationIdHistory;
  final List<QuestionModel> selectedQuestions;
  final List<int> userInputs;
  final QuestionBloc bloc;
  final int serviceId;
  final int selectedAnswerId;
  final Function() resetAnswerId;
  final Function() resetAnswersAndHistory;
  final List<TextEditingController> textEditingControllers;
  final QuestionModel question;
  final int nextRelationId;
  final int relationNow;
  const QuestionScreenButtons({
    super.key,
    required this.relationIdHistory,
    required this.selectedQuestions,
    required this.userInputs,
    required this.bloc,
    required this.serviceId,
    required this.selectedAnswerId,
    required this.resetAnswerId,
    required this.resetAnswersAndHistory,
    required this.textEditingControllers,
    required this.question,
    required this.nextRelationId,
    required this.relationNow,
  });

  @override
  State<QuestionScreenButtons> createState() => _QuestionScreenButtonsState();
}

class _QuestionScreenButtonsState extends State<QuestionScreenButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedIconWidget(
          onPressed: () {
            if (widget.relationIdHistory.isNotEmpty) {
              final lastQuestion = widget.selectedQuestions.last;
              if (lastQuestion.type == 'textbox') {
                for (int i = 0; i < lastQuestion.items.length; i++) {
                  if (widget.userInputs.isNotEmpty) {
                    widget.userInputs.removeLast();
                  }
                }
              }
              widget.selectedQuestions.removeLast();
              widget.bloc.add(
                NextQuestionRequest(
                  serviceId: widget.serviceId,
                  nextRelation: widget.relationIdHistory.last,
                  context: context,
                ),
              );
              widget.resetAnswersAndHistory();
              widget.textEditingControllers.clear();
            } else {
              return null;
            }
          },
          icon: Icons.arrow_back,
          tooltip: 'پیام قبل',
          isActive: widget.relationIdHistory.isNotEmpty,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        ElevatedIconWidget(
          onPressed: () {
            saveSelectedQuestion(
              question: widget.question,
              answerId: widget.selectedAnswerId,
              textEditingControllers: widget.textEditingControllers,
              selectedQuestions: widget.selectedQuestions,
              userInputs: widget.userInputs,
            );
            if (widget.nextRelationId != 0) {
              setState(() {
                widget.relationIdHistory.add(widget.relationNow);
              });
              widget.bloc.add(
                NextQuestionRequest(
                  serviceId: widget.serviceId,
                  nextRelation: widget.nextRelationId,
                  context: context,
                ),
              );
              widget.resetAnswerId();
              widget.textEditingControllers.clear();
            } else {
              BlocProvider.of<StepperBloc>(context).add(NextStep());
            }
          },
          icon: Icons.arrow_forward,
          tooltip: 'پیام بعد',
          isActive: widget.selectedAnswerId > -1 ||
              widget.textEditingControllers.isNotEmpty ||
              widget.nextRelationId == 0,
        ),
      ],
    );
  }
}
