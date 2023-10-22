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
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      onPressed: translationLmited ? moveToPremiumPlan : translate,
      child: Text(label, style: const TextStyle(color: Colors.green)),
    );
  }
}
