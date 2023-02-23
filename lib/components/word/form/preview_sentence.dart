import 'package:booqs_mobile/data/provider/sentence.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/components/sentence/item/edit_button.dart';
import 'package:booqs_mobile/components/sentence/item/tts_button.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/components/shared/text_with_dict_link.dart';
import 'package:booqs_mobile/components/word/item/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordFormPreviewSentence extends ConsumerWidget {
  const WordFormPreviewSentence({Key? key, required this.word})
      : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (word.sentenceId == null) {
      return Container();
    }
    final int sentenceId = word.sentenceId ?? 0;
    final future = ref.watch(asyncSentenceFamily(sentenceId));

    Widget sentence(Sentence? sentence) {
      if (sentence == null) {
        return Container();
      }
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 24),
        const WordItemLabel(text: '例文'),
        const SizedBox(height: 8),
        TextWithDictLink(
          text: sentence.original,
          langNumber: sentence.langNumberOfOriginal,
          dictionaryId: sentence.dictionaryId,
          autoLinkEnabled: true,
          crossAxisAlignment: CrossAxisAlignment.start,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          fontColor: Colors.black87,
          selectable: true,
        ),
        SentenceItemTTSButton(sentence: sentence),
        const SizedBox(height: 8),
        Text(sentence.translation,
            style: const TextStyle(
                fontSize: 16, height: 1.6, color: Colors.black87)),
        const SizedBox(height: 24),
        SentenceItemEditButton(
          sentence: sentence,
          isShow: false,
        ),
        const SizedBox(height: 24),
      ]);
    }

    return future.when(
      loading: () => const LoadingSpinner(),
      error: (err, stack) => Text('Error: $err'),
      data: (Sentence? data) => sentence(data),
    );
  }
}
