import 'package:bloc/bloc.dart';
import 'package:bpbm2/common/methods/load_token.dart';
import 'package:equatable/equatable.dart';

part 'stepper_event.dart';
part 'stepper_state.dart';

class StepperBloc extends Bloc<StepperEvent, StepperState> {
  StepperBloc() : super(StepperInitial()) {
    int step = 1;

    on<StepperEvent>((event, emit) async {
      if (event is StepperStarted) {
        String token = await loadToken();
        step = 1;
        emit(QuestionScreenSuccess());
      }

      if (event is NextStep) {
        String token = await loadToken();
        step++;
        if (step == 2) {
          emit(AddressScreenSuccess());
        } else if (step == 3) {
          emit(TimeScreenSuccess());
        } else if (step == 4) {
          if (token != '') {
            step++;
            emit(OrderSummarySuccess());
          } else if (token == '') {
            emit(UserScreenSuccess());
          }
        } else if (step == 5) {
          emit(OrderSummarySuccess());
        }
      }

      if (event is PreviousStep) {
        String token = await loadToken();
        step--;
        if (step == 1) {
          emit(QuestionScreenSuccess());
        } else if (step == 2) {
          emit(AddressScreenSuccess());
        } else if (step == 3) {
          emit(TimeScreenSuccess());
        } else if (step == 4) {
          if (token != '') {
            step--;
            emit(TimeScreenSuccess());
          } else {
            emit(UserScreenSuccess());
          }
        } else if (step == 5) {
          // if (token != null) {
          //   step--;
          //   emit(TimeScreenSuccess());
          // } else {
          //   emit(UserScreenSuccess());
          // }
        }
      }
    });
  }
}
