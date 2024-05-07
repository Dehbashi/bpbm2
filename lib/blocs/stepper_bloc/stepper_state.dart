part of 'stepper_bloc.dart';

sealed class StepperState extends Equatable {
  const StepperState();

  @override
  List<Object> get props => [];
}

final class StepperInitial extends StepperState {}

class QuestionScreenSuccess extends StepperState {}

class AddressScreenSuccess extends StepperState {}

class TimeScreenSuccess extends StepperState {}
