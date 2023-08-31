import 'package:booqs_mobile/components/user/form/lang_number.dart';
import 'package:booqs_mobile/components/user/form/learning_lang_number.dart';
import 'package:flutter/material.dart';

class UserFormLangSettings extends StatelessWidget {
  const UserFormLangSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserFormLangNumber(),
        SizedBox(height: 32),
        UserFormLearningLangNumber(),
        SizedBox(height: 32),
        // UserFormTimeZoneName(),
      ],
    );
  }
}
