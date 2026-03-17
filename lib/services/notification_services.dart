import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationServices {
  static final messaging = FirebaseMessaging.instance;

  static Future<void> initNotification() async {
    // Request permission
    await messaging.requestPermission();

    try {
      final notificationToken = await messaging.getToken();
      print('Notification Token: $notificationToken');
    } catch (_) {}

    // When app in background and come to foreground
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message.notification?.title);
      print(message.notification?.body);
    });

    // When app in terminated state
    // FirebaseMessaging.onBackgroundMessage((message) async {
    //   print(message.notification?.title);
    //   print(message.notification?.body);
    // });
  }
}
