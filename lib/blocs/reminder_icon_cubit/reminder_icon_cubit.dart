import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reminder_icon_state.dart';

class ReminderIconCubit extends Cubit<ReminderIconState> {
  ReminderIconCubit() : super(ReminderIconInitial());

  void changeCondition(int value) {
    value < 0
        ? emit(ReminderIconChange(false, value))
        : emit(ReminderIconChange(true, value));
  }

}
