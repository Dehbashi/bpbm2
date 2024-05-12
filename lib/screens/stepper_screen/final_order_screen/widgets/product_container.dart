import 'package:bpbm2/blocs/final_order_bloc/final_order_bloc.dart';
import 'package:bpbm2/data/models/question_model/question_item_model.dart';
import 'package:bpbm2/data/models/question_model/user_input_model.dart';
import 'package:bpbm2/screens/stepper_screen/final_order_screen/widgets/product_list_container.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class ProductContainer extends StatelessWidget {
  final FinalOrderSuccess state;
  const ProductContainer({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: Text(
              'لیست کالاهای درخواستی',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          ...state.products.map(
            (product) {
              if (product.type == 'radio') {
                return ProductListContainer(
                  product: product,
                  children: [
                    Icon(
                      Icons.monetization_on,
                      size: 15,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    Text(
                      '${product.items[0].price.toString().toPersianDigit().seRagham()} ریال',
                    ),
                  ],
                );
              } else if (product.type == 'textbox') {
                return ProductListContainer(
                  product: product,
                  children: [
                    ...product.items.map((item) {
                      final input = state.userInputs
                          .firstWhere((element) => element.item.id == item.id);
                      return ProductTextBoxList(item, input);
                    }),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'جمع کل: ${state.priceOfProducts.toString().toPersianDigit().seRagham()} ریال',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget ProductTextBoxList(QuestionItemModel item, UserInputModel input) {
    return Row(
      children: [
        Expanded(
          child: Text(item.title),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            input.userInput.toString().toPersianDigit(),
          ),
        ),
        Text(
          '${(item.price * input.userInput).toString().toPersianDigit().seRagham()} ریال',
        ),
      ],
    );
  }
}
