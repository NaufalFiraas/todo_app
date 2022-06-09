part of 'reminder_icon_cubit.dart';

abstract class ReminderIconState extends Equatable {
  final bool isDelay;
  final int value;

  const ReminderIconState(this.isDelay, this.value);
}

class ReminderIconInitial extends ReminderIconState {
  ReminderIconInitial() : super(false, 0);

  @override
  List<Object> get props => [isDelay, value];
}

class ReminderIconChange extends ReminderIconState {
  ReminderIconChange(bool isDelay, int value) : super(isDelay, value);

  @override
  List<Object?> get props => [isDelay, value];
}
