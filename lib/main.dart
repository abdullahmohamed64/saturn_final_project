import 'dart:io';

import 'package:flutter/material.dart';
import 'package:saturn/core/di/dependency_injection.dart';
import 'package:saturn/saturn_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpGetIt();
   HttpOverrides.global = MyHttpOverrides();
  runApp(const SaturnApp());
}

 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}