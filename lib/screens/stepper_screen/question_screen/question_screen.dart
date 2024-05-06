import 'package:bpbm2/blocs/question_bloc/question_bloc.dart';
import 'package:bpbm2/blocs/stepper_bloc/stepper_bloc.dart';
import 'package:bpbm2/common/widgets/elevated_icon_widget.dart';
import 'package:bpbm2/data/models/question_model/question_item_model.dart';
import 'package:bpbm2/data/models/question_model/question_model.dart';
import 'package:bpbm2/screens/stepper_screen/question_screen/widgets/question_screen_header.dart';
import 'package:bpbm2/screens/stepper_screen/question_screen/widgets/question_screen_list.dart';
import 'package:bpbm2/screens/stepper_screen/widgets/price_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionScreen extends StatefulWidget {
  final String serviceTitle;
  final int serviceId;
  const QuestionScreen({
    super.key,
    required this.serviceTitle,
    required this.serviceId,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late QuestionBloc bloc;
  int selectedAnswerId = -1;
  int nextRelationId = -1;
  int relationNow = -1;
  List<TextEditingController> textEditingControllers = [];
  List<int> relationIdHistory = [];
  late QuestionModel question;
  List<QuestionModel> selectedQuestions = [];
  List<int> userInputs = [];

  @override
  void initState() {
    bloc = BlocProvider.of<QuestionBloc>(context);
    bloc.add(
      QuestionStarted(
        context: context,
        serviceId: widget.serviceId,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    for (var textEditingController in textEditingControllers) {
      textEditingController.dispose();
    }
    super.dispose();
  }

  void saveSelectedQuestion({
    required QuestionModel question,
    required int answerId,
    required List<TextEditingController> textEditingControllers,
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
            (element) => int.parse(element.id) == i + 1,
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

  @override
  Widget build(BuildContext context) {
    print(userInputs.length);
    return Column(
      children: [
        QuestionScreenHeader(serviceTitle: widget.serviceTitle),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: BlocBuilder<QuestionBloc, QuestionState>(
            builder: (context, state) {
              if (state is QuestionSuccess) {
                question = state.questionService.question;
                relationNow = state.questionService.relation.now;
                return QuestionScreenList(
                  question: question,
                  selectedAnswerId: selectedAnswerId,
                  textEditingControllers: textEditingControllers,
                  onRadioChanged: (value) {
                    setState(() {
                      selectedAnswerId = value ?? -1;
                      nextRelationId =
                          int.parse(question.items[value! - 1].nextRelation);
                    });
                  },
                  onTextBoxChanged: (value) {
                    setState(() {
                      nextRelationId =
                          int.parse(question.items[0].nextRelation);
                    });
                  },
                );
              } else if (state is QuestionFinish) {
                return Container();
              } else if (state is QuestionFailed) {
                return const Center(
                  child: Text('خطا در دریافت سوالات'),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
        QuestionScreenButtons(context),
        const PriceContainer(price: 2000),
      ],
    );
  }

  Widget QuestionScreenButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedIconWidget(
          onPressed: () {
            if (relationIdHistory.isNotEmpty) {
              final lastQuestion = selectedQuestions.last;
              if (lastQuestion.type == 'textbox') {
                for (int i = 0; i < lastQuestion.items.length; i++) {
                  if (userInputs.isNotEmpty) {
                    userInputs.removeLast();
                  }
                }
              }
              selectedQuestions.removeLast();
              bloc.add(
                NextQuestionRequest(
                  serviceId: widget.serviceId,
                  nextRelation: relationIdHistory.last,
                  context: context,
                ),
              );
              setState(() {
                selectedAnswerId = -1;
                relationIdHistory.removeLast();
              });
              textEditingControllers.clear();
            } else {
              return null;
            }
          },
          icon: Icons.arrow_back,
          tooltip: 'پیام قبل',
          isActive: relationIdHistory.isNotEmpty,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        ElevatedIconWidget(
          onPressed: () {
            saveSelectedQuestion(
              question: question,
              answerId: selectedAnswerId,
              textEditingControllers: textEditingControllers,
            );
            if (nextRelationId != 0) {
              setState(() {
                relationIdHistory.add(relationNow);
              });
              bloc.add(
                NextQuestionRequest(
                  serviceId: widget.serviceId,
                  nextRelation: nextRelationId,
                  context: context,
                ),
              );
              setState(() {
                selectedAnswerId = -1;
              });
              textEditingControllers.clear();
            } else {
              BlocProvider.of<StepperBloc>(context).add(NextStep());
            }
          },
          icon: Icons.arrow_forward,
          tooltip: 'پیام بعد',
          isActive: selectedAnswerId > -1 ||
              textEditingControllers.isNotEmpty ||
              nextRelationId == 0,
        ),
      ],
    );
  }
}
