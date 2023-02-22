import 'package:booqs_mobile/data/provider/sentence.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/pages/sentence/show.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/components/shared/text_with_dict_link.dart';
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

    Widget embeddedSentence(Sentence? sentence) {
      if (sentence == null) {
        return Container();
      }
      return InkWell(
        onTap: () {
          SentenceShowPage.push(context, sentenceId);
        },
        child: DottedBorder(
          color: Colors.black54,
          strokeWidth: 1,
          padding:
              const EdgeInsets.only(top: 10, bottom: 16, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(height: 2),
              Text(
                sentence.translation,
                style: TextStyle(
                    fontSize: sentenceFontSize, color: Colors.black87),
              ),
            ],
          ),
        ),
      );
    }

    return future.when(
      data: (data) => embeddedSentence(data),
      error: (err, stack) => Text('Error: $err'),
      loading: () => const LoadingSpinner(),
    );
  }
}
