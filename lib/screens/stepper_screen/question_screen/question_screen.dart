import 'package:bpbm2/blocs/question_bloc/question_bloc.dart';
import 'package:bpbm2/data/models/question_model/question_model.dart';
import 'package:bpbm2/screens/stepper_screen/question_screen/widgets/question_screen_buttons.dart';
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
  // late QuestionModel question;
  QuestionModel question = const QuestionModel(
    id: 0,
    title: '',
    type: '',
    list: '',
    items: [],
  );
  List<QuestionModel> selectedQuestions = [];
  List<double> userInputs = [];

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<QuestionBloc>(context);
    bloc.add(
      QuestionStarted(
        context: context,
        serviceId: widget.serviceId,
      ),
    );
  }

  @override
  void dispose() {
    for (var textEditingController in textEditingControllers) {
      textEditingController.dispose();
    }
    super.dispose();
  }

  void resetAnswers() {
    setState(() {
      selectedAnswerId = -1;
    });
  }

  void resetAnswersAndHistory() {
    setState(() {
      selectedAnswerId = -1;
      relationIdHistory.removeLast();
    });
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
        QuestionScreenButtons(
          relationIdHistory: relationIdHistory,
          selectedQuestions: selectedQuestions,
          userInputs: userInputs,
          bloc: bloc,
          serviceId: widget.serviceId,
          resetAnswerId: resetAnswers,
          resetAnswersAndHistory: resetAnswersAndHistory,
          selectedAnswerId: selectedAnswerId,
          textEditingControllers: textEditingControllers,
          question: question,
          nextRelationId: nextRelationId,
          relationNow: relationNow,
        ),
        const PriceContainer(),
      ],
    );
  }
}
