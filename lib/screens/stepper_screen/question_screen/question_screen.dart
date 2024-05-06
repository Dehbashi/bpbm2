import 'package:bpbm2/blocs/question_bloc/question_bloc.dart';
import 'package:bpbm2/blocs/stepper_bloc/stepper_bloc.dart';
import 'package:bpbm2/common/widgets/elevated_icon_widget.dart';
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

  @override
  Widget build(BuildContext context) {
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
                final question = state.questionService.question;
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
