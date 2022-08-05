import 'package:booqs_mobile/data/provider/sentence.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/pages/sentence/show.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:booqs_mobile/widgets/shared/text_with_dict_link.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MarkdownEmbeddedSentence extends ConsumerWidget {
  const MarkdownEmbeddedSentence(
      {Key? key, required this.sentenceId, required this.fontSize})
      : super(key: key);
  final int sentenceId;
  final double fontSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final future = ref.watch(asyncSentenceFamily(sentenceId));
    final double sentenceFontSize = fontSize - 2;

    Widget _embeddedSentence(Sentence? sentence) {
      if (sentence == null) {
        return Container();
      }
      return DottedBorder(
        color: Colors.black54,
        strokeWidth: 1,
        padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
        child: Column(
          children: [
            TextWithDictLink(
              text: sentence.original,
              langNumber: sentence.langNumberOfOriginal,
              autoLinkEnabled: true,
              crossAxisAlignment: CrossAxisAlignment.start,
              dictionaryId: sentence.dictionaryId,
              fontSize: sentenceFontSize,
              fontWeight: FontWeight.normal,
              fontColor: Colors.black87,
              selectable: true,
            ),
            const SizedBox(height: 8),
            Text(
              sentence.translation,
              style:
                  TextStyle(fontSize: sentenceFontSize, color: Colors.black87),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(bottom: 0),
                  textStyle: TextStyle(
                    fontSize: sentenceFontSize - 2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () => SentenceShowPage.push(context, sentenceId),
                child: const Text('例文ページ',
                    style: TextStyle(
                      color: Colors.black54,
                      decoration: TextDecoration.underline,
                    )),
              ),
            ),
          ],
        ),
      );
    }

    return future.when(
      data: (data) => _embeddedSentence(data),
      error: (err, stack) => Text('Error: $err'),
      loading: () => const LoadingSpinner(),
    );
  }
}
