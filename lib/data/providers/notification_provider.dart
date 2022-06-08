import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationProvider {
  late final FlutterLocalNotificationsPlugin notification;

  NotificationProvider(
      [FlutterLocalNotificationsPlugin? optionalNotification]) {
    notification = optionalNotification ?? FlutterLocalNotificationsPlugin();
  }

  Future<void> init() async {
    print('init');
    AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    IOSInitializationSettings iOSSettings = IOSInitializationSettings();

    InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iOSSettings,
    );

    await notification.initialize(settings);
  }

  NotificationDetails notificationDetails() {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
        importance: Importance.max,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  Future<void> showScheduledNotif(
      int id, String title, String body, DateTime time) async {
    print('Execute showSchedule');
    notification.zonedSchedule(
      id,
      title,
      body,
      _makeSchedule(time),
      notificationDetails(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  tz.TZDateTime _makeSchedule(DateTime time) {
    final tz.Location location = tz.getLocation('Asia/Jakarta');
    final tz.TZDateTime schedule = tz.TZDateTime(
      location,
      time.year,
      time.month,
      time.day,
      time.hour,
      time.minute,
    );

    return schedule;
  }

  Future<void> cancelReminder(int id) async {
    notification.cancel(id);
  }
}
