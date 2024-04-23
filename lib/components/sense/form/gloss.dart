import 'package:booqs_mobile/components/form/white_text_form_field.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/widgets.dart';

class SenseFormGloss extends StatelessWidget {
  const SenseFormGloss({super.key, required this.glossController});
  final TextEditingController glossController;

  @override
  Widget build(BuildContext context) {
    return FormWhiteTextFormField(
      controller: glossController,
      label: t.senses.gloss,
      hint: '',
      emptyValidation: true,
      lineBreak: true,
    );
  }
}
