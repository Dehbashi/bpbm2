import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'stepper_event.dart';
part 'stepper_state.dart';

class StepperBloc extends Bloc<StepperEvent, StepperState> {
  StepperBloc() : super(StepperInitial()) {
    int step = 1;
    on<StepperEvent>((event, emit) async {
      if (event is StepperStarted) {
        step = 1;
        emit(QuestionScreenSuccess());
      }

      if (event is NextStep) {
        step++;
        if (step == 2) {
          emit(AddressScreenSuccess());
        }
      }

      if (event is PreviousStep) {
        step--;
        if (step == 1) {
          emit(QuestionScreenSuccess());
        }
      }
    });
  }
}
