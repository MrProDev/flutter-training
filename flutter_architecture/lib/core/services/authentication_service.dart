import 'dart:async';

import 'package:flutter_architecture/core/models/user.dart';

import '../../locator.dart';
import 'api.dart';

class AuthenticationService {
  final Api _api = locator<Api>();

  StreamController<User> userController = StreamController<User>();

  Future<bool> login(int userId) async {
    final fetchedUser = await _api.getUserProfile(userId);

    var hasUser = fetchedUser.id! > 0 && fetchedUser.id! <= 10;
    if (hasUser) {
      userController.add(fetchedUser);
    }

    return hasUser;
  }
}
