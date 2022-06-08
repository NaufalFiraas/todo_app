import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationProvider {
  late final FlutterLocalNotificationsPlugin notification;

  NotificationProvider(
      [FlutterLocalNotificationsPlugin? optionalNotification]) {
    notification = optionalNotification ?? FlutterLocalNotificationsPlugin();
  }

  Future<void> init() async {
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
        importance: Importance.max,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  Future<void> showScheduledNotif(
      int id, String title, String body, DateTime time) async {
    notification.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(time, tz.getLocation('Asia/Jakarta')),
      notificationDetails(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }
}
