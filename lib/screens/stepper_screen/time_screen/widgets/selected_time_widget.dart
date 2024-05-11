import 'package:bpbm2/blocs/time_bloc/time_bloc.dart';
import 'package:flutter/material.dart';

class SelectedTimeWidget extends StatelessWidget {
  final TimeSuccess state;
  final String selectedText;
  const SelectedTimeWidget({
    super.key,
    required this.state,
    required this.selectedText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'زمان انتخاب شده شما',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${state.pickedDate.title} $selectedText',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
