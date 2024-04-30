import 'package:flutter/material.dart';

class FaqWidget extends StatelessWidget {
  final String question;
  final String answer;

  const FaqWidget({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 6,
        right: 6,
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFCDEEF0),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(7),
                topLeft: Radius.circular(7),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ExpansionTile(
              shape: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              title: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  question,
                  // maxLines: 1,
                  // overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 30,
                  ),
                  child: Text(
                    answer,
                    style: Theme.of(context).textTheme.bodyMedium,
                    // textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
