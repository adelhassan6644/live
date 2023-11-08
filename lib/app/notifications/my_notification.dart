import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:live/navigation/custom_navigation.dart';
import 'package:live/navigation/routes.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('Handling a background message ${message.data}');
}

abstract class FirebaseNotifications {
  static FirebaseMessaging? _firebaseMessaging;
  static FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;
  static AndroidNotificationChannel? _channel;

  static init() async {

    _channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.high,
      description: 'This channel is used for important notifications.',
    );

    initDynamicLinks();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    _firebaseMessaging = FirebaseMessaging.instance;
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _flutterLocalNotificationsPlugin!.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
    _flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
    _flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel!);
    _flutterLocalNotificationsPlugin!.initialize(const InitializationSettings(
      android: AndroidInitializationSettings('@drawable/notification_icon'),
      iOS: IOSInitializationSettings(
          defaultPresentBadge: true,
          defaultPresentAlert: true,
          defaultPresentSound: true),
    ));
    _firebaseMessaging!.setAutoInitEnabled(true);
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    if (Platform.isIOS)
      _firebaseMessaging!.requestPermission(
          alert: true, announcement: true, badge: true, sound: true);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log('Handling on message ${message.data}');
      _flutterLocalNotificationsPlugin!.show(
        message.notification.hashCode,
        message.notification!.title,
        message.notification!.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channel!.id,
            _channel!.name,
            icon: '@drawable/notification_icon',
            channelDescription: _channel!.description,
          ),
        ),
      );
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('Handling message open app ${message.data}');
    });
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      log('Handling initial message  ${message?.data}');
    });
    _flutterLocalNotificationsPlugin!
        .getNotificationAppLaunchDetails()
        .then((value) {
      log('Handling if local notification launch app  ${value!.payload}');
    });
  }

  static FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  static Future<void> initDynamicLinks() async {
    // final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
    // if(initialLink!=null) {
    //   handleDeepLink(initialLink.link.path);
    // }
    dynamicLinks.onLink.listen((dynamicLinkData) {
      // Listen and retrieve dynamic links here
      final String deepLink = dynamicLinkData.link.toString(); // Get DEEP LINK

      final String path = dynamicLinkData.link.path;

      if (deepLink.isEmpty) return;
      handleDeepLink(path);
    }).onError((error) {

    });
    initUniLinks();
  }

  static Future<void> initUniLinks() async {
    try {
      final initialLink = await dynamicLinks.getInitialLink();
      if (initialLink == null) return;
      handleDeepLink(initialLink.link.path);
    } catch (e) {
      // Error
    }
  }

  static void handleDeepLink(String path) {
    CustomNavigator.push(Routes.PLACE_DETAILS,
        arguments: int.parse(path.replaceAll('/', '')));
    // navigate to detailed product screen
  }

  static scheduleNotification(String title, String subtitle) async {
    var rng = math.Random();
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.high, priority: Priority.high, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin!.show(
        rng.nextInt(100000), title, subtitle, platformChannelSpecifics,
        payload: 'item x');
  }
}
