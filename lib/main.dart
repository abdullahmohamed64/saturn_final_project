import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:saturn/core/di/dependency_injection.dart';
import 'package:saturn/core/helper/shared_pref_helper.dart';
import 'package:saturn/core/networking/api_constants.dart';
import 'package:saturn/features/chat/data/models/firebase_notifications.dart';
import 'package:saturn/firebase_options.dart';
import 'package:saturn/saturn_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  HttpOverrides.global = MyHttpOverrides();
  await ApiConstants.initialize();

  setUpGetIt();
  getIt<SharedPrefHelper>().init();
  // In your main app initialization
  // final notificationService = FirebaseNotifications();
//  await notificationService.initNotifications();

  // Save FCM token when user logs in

  runApp(const SaturnApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
