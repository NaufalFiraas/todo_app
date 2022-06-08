import 'package:todo_app/data/models/todo_reminder.dart';
import 'package:todo_app/data/providers/notification_provider.dart';

class NotifReminderRepository {
  late final NotificationProvider provider;

  NotifReminderRepository([NotificationProvider? optionalProvider]) {
    provider = optionalProvider ?? NotificationProvider();
  }

  Future<void> initNotif() async {
    await provider.init();
  }

  void setReminder(TodoReminder todoReminder) {
    provider.showScheduledNotif(
      todoReminder.id,
      todoReminder.title,
      todoReminder.body,
      todoReminder.time,
    );
  }

  void cancelReminder(int id) {
    provider.cancelReminder(id);
  }
}
