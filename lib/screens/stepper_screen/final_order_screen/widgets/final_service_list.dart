import 'package:bpbm2/data/models/question_model/question_item_model.dart';
import 'package:bpbm2/data/models/question_model/question_model.dart';
import 'package:bpbm2/data/models/question_model/user_input_model.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class FinalServiceList extends StatelessWidget {
  final QuestionModel service;
  final List<UserInputModel> userInputs;
  const FinalServiceList({
    super.key,
    required this.service,
    required this.userInputs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.comment,
                size: 15,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(service.title),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          if (service.type == 'radio')
            ServiceRadioWidget(context),
          if (service.type == 'textbox')
            ...service.items.map((item) {
              final input = userInputs
                  .firstWhere((element) => element.item.id == item.id);
              return ServiceTextBoxWidget(context, item, input);
            })
        ],
      ),
    );
  }

  Widget ServiceTextBoxWidget(BuildContext context, QuestionItemModel item, UserInputModel input) {
    return Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_forward,
                    size: 15,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(item.title),
                  ),
                  const SizedBox(width: 10,),
                  Text(input.userInput.toString().toPersianDigit()),
                  Expanded(
                    child: Icon(
                      Icons.monetization_on,
                      size: 25,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  Text('${(item.price * input.userInput).toString().toPersianDigit().seRagham()} ریال'),
                ],
              ),
            );
  }

  Widget ServiceRadioWidget(BuildContext context) {
    return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.arrow_forward,
                size: 15,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  service.items[0].title,
                  // maxLines: 1,
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                child: Icon(
                  Icons.monetization_on,
                  size: 25,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              Text(
                '${service.items[0].price.toString().toPersianDigit().seRagham()} ریال',
              ),
            ],
          );
  }
}
