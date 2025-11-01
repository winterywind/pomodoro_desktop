import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final notificationPlugin = FlutterLocalNotificationsPlugin();

  final bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  Future<void> initNotifications() async {
    if (_isInitialized) return;
    final DarwinInitializationSettings iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true
    );

    final LinuxInitializationSettings linuxInit = LinuxInitializationSettings(
      defaultActionName: 'Open notification',
    );

    final WindowsInitializationSettings winInit = WindowsInitializationSettings(
      appName: 'Pomodoro',
      appUserModelId: 'com.example.pomodoro_desktop',
      guid: 'b23eff73-402e-4264-bb28-4fac5df32c71',
    );

    final InitializationSettings initSettings = InitializationSettings(
      macOS: iosInit,
      linux: linuxInit,
      windows: winInit
    );

    await notificationPlugin.initialize(initSettings);
  }

  NotificationDetails notificationDetails() {
    return NotificationDetails(
      macOS: DarwinNotificationDetails(presentSound: true, sound: 'default'),
      linux: LinuxNotificationDetails(),
      windows: WindowsNotificationDetails(audio: WindowsNotificationAudio.preset(sound: WindowsNotificationSound.alarm1))
    );
  }

  Future<void> showNotification(String title) async {
    await notificationPlugin.show(1, title, '', notificationDetails());
  }
}
