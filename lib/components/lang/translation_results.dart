import 'package:booqs_mobile/utils/language_handler.dart';
import 'package:flutter/material.dart';

class LangTranslationResults extends StatelessWidget {
  const LangTranslationResults(
      {super.key,
      required this.label,
      required this.sourceLangNumber,
      required this.targetLangNumber,
      required this.results});
  final String label;
  final int sourceLangNumber;
  final int targetLangNumber;
  final String? results;

  @override
  Widget build(BuildContext context) {
    if (results == null) {
      return Container();
    }
    // 言語情報を生成
    final String sourceLanguage =
        LanguageHandler.getLanguageFromNumber(sourceLangNumber);
    final String targetLanguage =
        LanguageHandler.getLanguageFromNumber(targetLangNumber);
    final String translationInfo = '$sourceLanguage - $targetLanguage';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          '$label ($translationInfo)：',
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        SelectableText('$results',
            style: const TextStyle(fontSize: 14, color: Colors.black87)),
      ],
    );
  }
}
