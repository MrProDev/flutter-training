import 'package:flutter_architecture/core/enums/viewstate.dart';
import 'package:flutter_architecture/core/services/authentication_service.dart';
import 'package:flutter_architecture/core/viewmodels/base_model.dart';

import '../../locator.dart';

class LoginModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  String errorMessage = '';

  Future<bool> login(String userIdText) async {
    setState(ViewState.busy);

    int? userId = int.tryParse(userIdText);

    // Not a number
    if (userId == null) {
      errorMessage = 'Value entered is not a number';
      setState(ViewState.idle);
      return false;
    }

    if (userId <= 0 || userId > 10) {
      errorMessage = 'Enter a number between 1-10';
      setState(ViewState.idle);
      return false;
    }

    var success = await _authenticationService.login(userId);

    // Handle potential error here too.

    setState(ViewState.idle);
    return success;
  }
}
