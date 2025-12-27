import 'package:booqs_mobile/components/markdown/markdown_without_dict_link.dart';
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
    if (aiSearcher == null) {
      if (isRequesting) {
        return const LoadingSpinner();
      }
      return Container();
    }
    final String result = aiSearcher?.results ?? '';
    final String promptKey = aiSearcher?.promptKey ?? '';
    final String prompt =
        promptKey.isEmpty ? t.lang.ask_ai : '${t['lang.$promptKey']}:';
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Text(prompt,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  fontWeight: FontWeight.bold)),
          if (isRequesting) ...[
            const SizedBox(width: 8),
            const SizedBox(
              height: 14,
              width: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.green,
              ),
            ),
          ],
        ],
      ),
      const SizedBox(height: 16),
      MarkdownWithoutDictLink(
        fontColor: Colors.black87,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        selectable: true,
        text: result,
      ),
    ]);
  }
}
