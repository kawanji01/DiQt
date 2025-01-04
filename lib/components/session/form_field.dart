import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

// IDとパスワードのフォーム https://flutterawesome.com/basic-login-and-signup-screen-designed-in-flutter/
class SessionFormField extends StatelessWidget {
  const SessionFormField(
      {super.key,
      required this.label,
      required this.controller,
      required this.isPassword,
      required this.keyText});
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final String keyText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            key: Key(keyText),
            controller: controller,
            obscureText: isPassword,
            decoration: const InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return t.errors.cant_be_blank;
              }
              return null;
            },
          )
        ],
      ),
    );
  }
}
