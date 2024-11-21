import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

/// 알림 초기화
Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const DarwinInitializationSettings initializationSettingsDarwin =
  DarwinInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      print('Notification clicked: ${response.payload}');
    },
  );
}

/// 권한 요청 (iOS 전용)
Future<void> requestPermissions() async {
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
    alert: true,
    badge: true,
    sound: true,
  );
}

/// 12시간 알림 스케줄링
Future<void> schedule12HourNotification() async {
  tz.initializeTimeZones();

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    'repeat_channel_id',
    'repeat_channel_name',
    channelDescription: '12시간마다 알림을 보내는 채널',
    importance: Importance.max,
    priority: Priority.high,
  );

  const DarwinNotificationDetails iosPlatformChannelSpecifics =
  DarwinNotificationDetails();

  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iosPlatformChannelSpecifics,
  );

  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

  await flutterLocalNotificationsPlugin.zonedSchedule(
    0, // 알림 ID
    '명언을 확인할 수 있어요!', // 제목
    '오늘의 명언을 확인하세요!', // 내용
    now.add(const Duration(hours: 12)), // 처음 알림 시간
    platformChannelSpecifics,
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
    UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time, // 매일 같은 시간 반복
  );
}

// //  알림 초기화
// await initializeNotifications();
//
// // iOS 권한 요청
// await requestPermissions();
//
// // 12시간 알림 스케줄링
// await schedule12HourNotification();