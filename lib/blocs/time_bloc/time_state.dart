part of 'time_bloc.dart';

sealed class TimeState extends Equatable {
  const TimeState();

  @override
  List<Object> get props => [];
}

final class TimeInitial extends TimeState {}

class TimeSuccess extends TimeState {
  final List<TimeModel> dates;
  final TimeModel pickedDate;
  final bool morningSelected;

  const TimeSuccess({
    required this.dates,
    required this.pickedDate,
    required this.morningSelected,
  });

  @override
  List<Object> get props => [
        dates,
        pickedDate,
        morningSelected,
      ];
}

class TimeFailed extends TimeState {}
