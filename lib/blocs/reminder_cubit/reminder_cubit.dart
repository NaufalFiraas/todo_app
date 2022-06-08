import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/data/models/todo_reminder.dart';
import 'package:todo_app/data/repositories/notif_reminder_repository.dart';

part 'reminder_state.dart';

class ReminderCubit extends Cubit<ReminderState> {
  late final NotifReminderRepository repo;

  ReminderCubit([NotifReminderRepository? optionalRepo])
      : super(ReminderInitial()) {
    repo = optionalRepo ?? NotifReminderRepository();
  }

  void setReminder(TodoReminder todoReminder) {
    repo.setReminder(todoReminder);
  }

  void cancelReminder(TodoReminder todoReminder) {
    repo.cancelReminder(todoReminder);
  }
}
