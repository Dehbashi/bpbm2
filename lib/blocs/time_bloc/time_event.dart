part of 'time_bloc.dart';

sealed class TimeEvent extends Equatable {
  const TimeEvent();

  @override
  List<Object> get props => [];
}

class TimeStarted extends TimeEvent {}

class DateChanged extends TimeEvent {
  final TimeModel pickedDate;

  const DateChanged({
    required this.pickedDate,
  });

  @override
  List<Object> get props => [pickedDate];
}

class TimeChanged extends TimeEvent {}

class TimeSaved extends TimeEvent {
  final TimeModel pickedDate;
  final String pickedTime;

  const TimeSaved({
    required this.pickedDate,
    required this.pickedTime,
  });

  @override
  List<Object> get props => [
        pickedDate,
        pickedTime,
      ];
}
