import 'package:bpbm2/data/models/question_model/question_model.dart';
import 'package:flutter/material.dart';

class ProductListContainer extends StatelessWidget {
  final QuestionModel product;
  final List<Widget> children;
  const ProductListContainer({
    super.key,
    required this.product,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product.title),
          const SizedBox(
            height: 10,
          ),
          ...children,
        ],
      ),
    );
  }
}
