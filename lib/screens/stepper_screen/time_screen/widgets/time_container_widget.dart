import 'package:bpbm2/blocs/stepper_bloc/stepper_bloc.dart';
import 'package:bpbm2/blocs/time_bloc/time_bloc.dart';
import 'package:bpbm2/common/screen_texts_images/stepper_time_screen_content.dart';
import 'package:bpbm2/providers/price_provider.dart';
import 'package:bpbm2/screens/stepper_screen/time_screen/widgets/selected_time_widget.dart';
import 'package:bpbm2/screens/stepper_screen/time_screen/widgets/time_widget.dart';
import 'package:bpbm2/screens/stepper_screen/widgets/stepper_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TimeContainerWidget extends StatelessWidget {
  final TimeSuccess state;
  const TimeContainerWidget({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PriceProvider>(context, listen: false);
    String selectedTime = state.morningSelected
        ? '$morningText $startHourText $morningStartHour $endHourText $morningEndHour'
        : '$eveningText $startHourText $eveningStartHour $endHourText $eveningEndHour';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton(
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(10),
                  underline: Container(),
                  autofocus: true,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  value: state.pickedDate,
                  items: state.dates.map((date) {
                    return DropdownMenuItem(
                      value: date,
                      child: Text(
                        '${date.title} ${date.text}',
                      ),
                    );
                  }).toList(),
                  onChanged: (pickedDate) {
                    BlocProvider.of<TimeBloc>(context).add(
                      DateChanged(
                        pickedDate: pickedDate!,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  TimeWidget(
                    text: '$morningText\n'
                        '$startHourText $morningStartHour\n'
                        '$endHourText $morningEndHour',
                    morningSelected: state.morningSelected,
                    state: state,
                    onTap: () {
                      state.morningSelected
                          ? null
                          : BlocProvider.of<TimeBloc>(context)
                              .add(TimeChanged());
                    },
                  ),
                  TimeWidget(
                    text: '$eveningText\n'
                        '$startHourText $eveningStartHour\n'
                        '$endHourText $eveningEndHour',
                    morningSelected: !state.morningSelected,
                    state: state,
                    onTap: () {
                      !state.morningSelected
                          ? null
                          : BlocProvider.of<TimeBloc>(context)
                              .add(TimeChanged());
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SelectedTimeWidget(
          state: state,
          selectedText: selectedTime,
        ),
        const SizedBox(
          height: 10,
        ),
        StepperButtons(
          onBackPressed: () {
            provider.backButtonClicked();
            BlocProvider.of<StepperBloc>(context).add(PreviousStep());
          },
          onNextPressed: () {
            BlocProvider.of<TimeBloc>(context).add(
              TimeSaved(
                pickedDate: state.pickedDate,
                pickedTime: selectedTime,
              ),
            );
            BlocProvider.of<StepperBloc>(context).add(NextStep());
          },
        ),
      ],
    );
  }
}
