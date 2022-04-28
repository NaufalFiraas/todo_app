part of 'time_cubit.dart';

abstract class TimeState extends Equatable {
  final TimeOfDay time;

  const TimeState(this.time);
}

class TimeNow extends TimeState {
  TimeNow() : super(TimeOfDay.now());

  @override
  List<Object> get props => [time];
}

class TimeLoaded extends TimeState {
  const TimeLoaded(TimeOfDay time) : super(time);

  @override
  List<Object?> get props => [time];
}
