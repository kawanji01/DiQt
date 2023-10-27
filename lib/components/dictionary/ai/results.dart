import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/ai_searcher.dart';
import 'package:flutter/material.dart';

class DictionaryAIResults extends StatelessWidget {
  const DictionaryAIResults(
      {super.key, required this.aiSearcher, required this.isRequesting});
  final AISearcher? aiSearcher;
  final bool isRequesting;

  @override
  Widget build(BuildContext context) {
    if (isRequesting) {
      return const LoadingSpinner();
    }
    if (aiSearcher == null) {
      return Container();
    }
    final String result = '${aiSearcher?.results}';
    final String prompt = t['lang.${aiSearcher?.promptKey}'];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(prompt,
          style: const TextStyle(
              fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      Text(result,
          style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.normal)),
    ]);
  }
}
