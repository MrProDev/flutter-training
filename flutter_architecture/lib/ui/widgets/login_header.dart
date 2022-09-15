import 'package:flutter/material.dart';
import 'package:flutter_architecture/ui/shared/text_styles.dart';

class LoginHeader extends StatelessWidget {
  final TextEditingController controller;
  final String? validationMessage;

  const LoginHeader(
      {super.key, required this.controller, this.validationMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text('Find Posts', style: headerStyle),
        LoginTextField(controller),
        validationMessage != null
            ? Text(validationMessage ?? '',
                style: const TextStyle(color: Colors.red))
            : Container()
      ],
    );
  }
}

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;

  const LoginTextField(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      height: 50.0,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: TextField(
          decoration: const InputDecoration.collapsed(hintText: 'User Id'),
          controller: controller),
    );
  }
}
