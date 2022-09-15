import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/enums/viewstate.dart';
import 'package:flutter_architecture/core/viewmodels/login_model.dart';
import 'package:flutter_architecture/ui/shared/app_colors.dart';
import 'package:flutter_architecture/ui/shared/ui_helpers.dart';
import 'package:flutter_architecture/ui/widgets/login_header.dart';

import 'base_view.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      onModelReady: (model) {},
      builder: (context, model, child) => Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoginHeader(
              validationMessage: model.errorMessage,
              controller: _controller,
            ),
            UIHelper.verticalSpaceMedium(),
            model.state == ViewState.busy
                ? const CircularProgressIndicator()
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text(
                        'Find',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () async {
                        final navigator = Navigator.of(context);
                        var loginSuccess = await model.login(_controller.text);
                        if (loginSuccess) {
                          navigator.pushNamed('/');
                        }
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
