// import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// enum APP_STATE {
//   FOREGROUND,
//   ON_CLICK,
//   BACKGROUND,
//   APP_KILLED,
// }

// class PushNoticationService {
//   final FirebaseMessaging _fcm = FirebaseMessaging.instance;

//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   final AndroidNotificationChannel _channel = const AndroidNotificationChannel(
//     'high_importance_channel',
//     'High Importance Notifications',
//     description: 'This channel is used for important notifications.',
//   );

//   initializeFcmNotification() async {
//     var initializationSettingsAndroid =
//         const AndroidInitializationSettings('mipmap/ic_launcher');
//     var initializationSettingsIOS = const DarwinInitializationSettings();
//     var initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//     _flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse: onSelectNotification);
//     await _fcm.requestPermission();
//     // getToken();
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print("onMessage: $message");
//       handleMessage(message, APP_STATE.FOREGROUND);
//     });

//     FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print("onMessageOpenedApp: $message");
//       handleMessage(message, APP_STATE.ON_CLICK);
//     });
//   }

//   getToken() async {
//     String? token;
//     if (Platform.isIOS) {
//       token = await _fcm.getAPNSToken();
//     } else {
//       token = await _fcm.getToken();
//     }
//     return token;
//   }

//   void onSelectNotification(NotificationResponse response) async {
//     print('cccc$response');
//   }

//   handleMessage(RemoteMessage message, APP_STATE state) async {
//     try {
//       if (state == APP_STATE.FOREGROUND) {
//         String? title = message.notification?.title;
//         String? description = message.notification?.body;
//         showNotification(title: title ?? '', body: description ?? '');
//       }
//       if (state == APP_STATE.ON_CLICK) {
//         // onPressNoTi(action);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   onPressNoTi(String action, {String? id}) {}

//   showNotification({String title = '', String body = ''}) async {
//     var android = AndroidNotificationDetails(_channel.id, _channel.name,
//         channelDescription: _channel.description,
//         importance: Importance.max,
//         priority: Priority.high,
//         ticker: 'ticker');
//     var iOS = const DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );
//     var platform = NotificationDetails(android: android, iOS: iOS);
//     await _flutterLocalNotificationsPlugin.show(0, title, body, platform);
//   }
// }

// Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
//   return null;
// }
