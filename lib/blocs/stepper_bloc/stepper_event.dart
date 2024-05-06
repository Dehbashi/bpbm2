part of 'stepper_bloc.dart';

sealed class StepperEvent extends Equatable {
  const StepperEvent();

  @override
  List<Object> get props => [];
}

class StepperStarted extends StepperEvent {}

class NextStep extends StepperEvent {}

class PreviousStep extends StepperEvent {}
