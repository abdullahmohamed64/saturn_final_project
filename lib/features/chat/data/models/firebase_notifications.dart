// import 'dart:developer';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:saturn/core/routing/routes.dart';
// import 'package:saturn/saturn_app.dart';

// class FirebaseNotifications {
//   //* create instance of fcm
//   final FirebaseMessaging _fcm = FirebaseMessaging.instance;
//   //* initialize ntifications for the app
//   Future<void> initNotifications() async {
//     await _fcm.requestPermission();
//     final fcmToken = await _fcm.getToken();
//     log("\n\n\n\n************** --token ${fcmToken!}");
//    await handleBakgroundNotifications();
//   }

//   //* handle notifications when receive
//   void handleMessage(RemoteMessage? message) {
//     if (message == null) return;

//     log(message.notification?.title ?? "no title found");
//     log(message.notification?.body ?? "no body found");
//     // log("\n\n\n\n**************--message ${message.notification!.title}");
//     navigateKey.currentState!.pushNamedAndRemoveUntil(
//       Routes.chatPage,
//       (route) => false,
//     );
//   }
//   //* handle notifications when it is terminated

//   Future<void> handleBakgroundNotifications() async {
//     log("\n\n\n\n**************--background1");

//     _fcm.getInitialMessage().then(handleMessage);
//     log("\n\n\n\n**************--background2");

//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//     log("\n\n\n\n**************--background3");
//   }
// }

import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:saturn/core/routing/routes.dart';
import 'package:saturn/saturn_app.dart';

class FirebaseNotifications {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    // Request permission for notifications
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User declined or has not accepted permission');
    }

    final fcmToken = await _fcm.getToken();
    log("FCM Token: $fcmToken");

    // Handle background and terminated app notifications
    await handleBackgroundNotifications();

    // Handle foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Received a message while in the foreground!');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification}');
        // You can show a local notification here if needed
        _showForegroundNotification(message);
      }
    });
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    log('Handling message: ${message.data}');

    // Extract chat data from the message
    String? chatId = message.data['chatId'];
    String? senderId = message.data['senderId'];
    String? messageType = message.data['type'];

    if (messageType == 'chat_message' && chatId != null) {
      // Navigate to specific chat
      navigator.currentState?.pushNamed(
        Routes.chatPage,
        arguments: {'chatId': chatId, 'senderId': senderId},
      );
    } else {
      // Default navigation
      navigator.currentState?.pushNamedAndRemoveUntil(
        Routes.chatPage,
        (route) => false,
      );
    }
  }

  Future<void> handleBackgroundNotifications() async {
    // Handle notification when app is terminated
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      log('App opened from terminated state via notification');
      handleMessage(message);
    });

    // Handle notification when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      log('App opened from background via notification');
      handleMessage(message);
    });
  }

  void _showForegroundNotification(RemoteMessage message) {
    // Here you can implement local notification display
    // This is useful when the app is in foreground and you want to show
    // a notification banner or popup

    log('Showing foreground notification');
    log('Title: ${message.notification?.title}');
    log('Body: ${message.notification?.body}');

    // You can use flutter_local_notifications package here
    // to show notifications when app is in foreground
  }

  // Get current FCM token
  Future<String?> getToken() async {
    try {
      return await _fcm.getToken();
    } catch (e) {
      log('Error getting FCM token: $e');
      return null;
    }
  }

  // Subscribe to topic (useful for broadcast messages)
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _fcm.subscribeToTopic(topic);
      log('Subscribed to topic: $topic');
    } catch (e) {
      log('Error subscribing to topic: $e');
    }
  }

  // Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _fcm.unsubscribeFromTopic(topic);
      log('Unsubscribed from topic: $topic');
    } catch (e) {
      log('Error unsubscribing from topic: $e');
    }
  }
}
