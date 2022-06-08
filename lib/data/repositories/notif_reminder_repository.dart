import 'package:todo_app/data/models/todo_reminder.dart';
import 'package:todo_app/data/providers/notification_provider.dart';

class NotifReminderRepository {
  late final NotificationProvider provider;

  NotifReminderRepository([NotificationProvider? optionalProvider]) {
    provider = optionalProvider ?? NotificationProvider();
  }

  void setReminder(TodoReminder todoReminder) {
    provider.showScheduledNotif(
      todoReminder.id,
      todoReminder.title,
      todoReminder.body,
      todoReminder.time,
    );
  }

  void cancelReminder(TodoReminder todoReminder) {
    provider.cancelReminder(todoReminder.id);
  }
}
