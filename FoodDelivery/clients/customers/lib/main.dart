import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customers/app/app.locator.dart';
import 'package:customers/app/app.router.dart';
import 'package:customers/firebase_options.dart';
import 'package:customers/ui/shared/setup_dialog_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

const bool useEmulator = true;

// ignore: unused_element
Future _connectToFirebaseEmulator() async {
  final localHostString = Platform.isAndroid ? '10.0.0.2' : 'localhost';

  FirebaseFirestore.instance.settings = Settings(
    sslEnabled: false,
    persistenceEnabled: false,
    host: '$localHostString:8080',
  );

  await FirebaseAuth.instance.useAuthEmulator('http://$localHostString', 9099);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // if (useEmulator) {
  //   await _connectToFirebaseEmulator();
  // }
  await setupLocator();
  setupDialogUi();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.loginView,
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      debugShowCheckedModeBanner: false,
      onUnknownRoute: (settings) =>
          StackedRouter().onGenerateRoute(settings, Routes.startUpView),
    );
  }
}
