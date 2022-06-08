part of 'reminder_cubit.dart';

abstract class ReminderState extends Equatable {
  final int delay;

  const ReminderState(this.delay);
}

class ReminderInitial extends ReminderState {
  ReminderInitial() : super(0);

  @override
  List<Object> get props => [delay];
}

class ReminderChange extends ReminderState {
  ReminderChange(int delay) : super(delay);

  @override
  List<Object?> get props => [delay];

}
