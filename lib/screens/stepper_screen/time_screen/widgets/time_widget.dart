import 'package:bpbm2/blocs/time_bloc/time_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimeWidget extends StatelessWidget {
  final String text;
  final bool morningSelected;
  final TimeSuccess state;
  const TimeWidget({
    super.key,
    required this.text,
    required this.morningSelected,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          BlocProvider.of<TimeBloc>(context).add(TimeChanged());
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: morningSelected
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
