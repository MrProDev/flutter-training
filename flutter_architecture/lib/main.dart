import 'package:flutter/material.dart';
import 'package:flutter_architecture/router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_architecture/core/services/authentication_service.dart';
import 'package:flutter_architecture/locator.dart';

import 'core/models/user.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>(
      initialData: User.initial(),
      create: (context) =>
          locator<AuthenticationService>().userController.stream,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        initialRoute: 'login',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
