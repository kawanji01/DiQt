import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class LangTranslationButton extends StatelessWidget {
  const LangTranslationButton(
      {super.key,
      required this.label,
      required this.isTranslating,
      required this.translation,
      required this.translationLmited,
      required this.translate,
      required this.moveToPremiumPlan});
  final String label;
  final bool isTranslating;
  final String? translation;
  final bool translationLmited;
  final void Function() translate;
  final void Function() moveToPremiumPlan;

  @override
  Widget build(BuildContext context) {
    const TextStyle styleText = TextStyle(fontSize: 14, color: Colors.black87);
    if (isTranslating) {
      if (translation == null) {
        return Text(
          t.lang.translating,
          style: styleText,
        );
      }
      return Text(
        t.lang.done,
        style: styleText,
      );
    }
    return TextButton(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        minimumSize: WidgetStateProperty.all(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: translationLmited ? moveToPremiumPlan : translate,
      child: Text(label,
          style: const TextStyle(
            color: Colors.green,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
          )),
    );
  }
}
