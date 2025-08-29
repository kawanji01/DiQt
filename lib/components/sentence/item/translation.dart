import 'package:booqs_mobile/models/sentence.dart';
import 'package:flutter/material.dart';

class SentenceItemTranslation extends StatelessWidget {
  const SentenceItemTranslation({super.key, required this.sentence});
  final Sentence sentence;

  @override
  Widget build(BuildContext context) {
    if (sentence.langNumberOfOriginal == sentence.langNumberOfTranslation) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          sentence.translation,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        // 英語の場合
        if (sentence.langCodeOfTranslation() == 'ja' &&
            sentence.translationEn != null &&
            sentence.translationEn!.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            sentence.translationEn!,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
        // 日本語の場合
        if (sentence.langCodeOfTranslation() == 'en' &&
            sentence.translationJa != null &&
            sentence.translationJa!.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            sentence.translationJa!,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ],
    );
  }
}
