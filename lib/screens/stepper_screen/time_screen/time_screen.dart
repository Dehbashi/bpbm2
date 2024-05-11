import 'package:bpbm2/blocs/time_bloc/time_bloc.dart';
import 'package:bpbm2/screens/stepper_screen/time_screen/widgets/time_container_widget.dart';
import 'package:bpbm2/screens/stepper_screen/widgets/price_container.dart';
import 'package:bpbm2/screens/stepper_screen/widgets/stepper_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimeScreen extends StatelessWidget {
  const TimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TimeBloc>(context).add(TimeStarted());
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PriceContainer(),
          Text(
            'انتخاب زمان سرویس',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'دوست دارید چه زمانی کارشناس بسپارش به ما به شما مراجعه کنه؟',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<TimeBloc, TimeState>(
            builder: (context, state) {
              if (state is TimeFailed) {
                return const Center(
                  child: Text('خطای نامشخص'),
                );
              } else if (state is TimeSuccess) {
                return TimeContainerWidget(
                  state: state,
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
