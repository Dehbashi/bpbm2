import 'package:bpbm2/common/constants.dart';
import 'package:bpbm2/data/models/question_model/question_model.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class QuestionScreenList extends StatefulWidget {
  final QuestionModel question;
  final int selectedAnswerId;
  final void Function(int?)? onRadioChanged;
  final void Function(String)? onTextBoxChanged;
  final List<TextEditingController>? textEditingControllers;
  const QuestionScreenList({
    super.key,
    required this.question,
    required this.selectedAnswerId,
    required this.onRadioChanged,
    required this.onTextBoxChanged,
    this.textEditingControllers,
  });

  @override
  State<QuestionScreenList> createState() => _QuestionScreenListState();
}

class _QuestionScreenListState extends State<QuestionScreenList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.question.title),
            if (widget.question.type == 'radio')
              ListView.builder(
                physics: defaultScrollPhysics,
                shrinkWrap: true,
                itemCount: widget.question.items.length,
                itemBuilder: (context, index) {
                  final answer = widget.question.items[index];
                  return RadioListTile(
                    fillColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.onBackground,
                    ),
                    title: Text(
                      answer.title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    value: int.parse(answer.id),
                    groupValue: widget.selectedAnswerId,
                    onChanged: widget.onRadioChanged,
                  );
                },
              ),
            if (widget.question.type == 'textbox')
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.question.items.length,
                itemBuilder: (context, index) {
                  for (int i = 0; i < widget.question.items.length; i++) {
                    if (widget.textEditingControllers!.length <
                        widget.question.items.length) {
                      widget.textEditingControllers!
                          .add(TextEditingController());
                    }
                  }
                  final answer = widget.question.items[index];
                  return TextField(
                    controller: widget.textEditingControllers![index],
                    decoration: InputDecoration(
                      label: Text(
                          '${answer.title} (${answer.price.toString().toPersianDigit().seRagham()} ریال)'),
                      labelStyle: Theme.of(context).textTheme.labelSmall,
                    ),
                    onChanged: widget.onTextBoxChanged,
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
