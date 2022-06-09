part of 'reminder_cubit.dart';

abstract class ReminderState extends Equatable {
  final bool isDelay;
  final int value;

  const ReminderState(this.isDelay, this.value);
}

class ReminderInitial extends ReminderState {
  ReminderInitial() : super(false, -1);

  @override
  List<Object?> get props => [isDelay, value];
}

class ReminderChange extends ReminderState {
  ReminderChange(bool isDelay, int value) : super(isDelay, value);

  @override
  List<Object?> get props => [isDelay, value];

}
