import 'package:booqs_mobile/components/sentence/item/content.dart';
import 'package:booqs_mobile/data/provider/sentence.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/components/sentence/item/edit_button.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentencePreview extends ConsumerWidget {
  const SentencePreview({Key? key, required this.sentenceId}) : super(key: key);
  final int? sentenceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (sentenceId == null) {
      return Container();
    }

    final future = ref.watch(asyncSentenceFamily(sentenceId!));

    Widget sentence(Sentence? sentence) {
      if (sentence == null) {
        return Container();
      }
      return DottedBorder(
        color: Colors.black54,
        strokeWidth: 1,
        padding:
            const EdgeInsets.only(top: 10, bottom: 16, left: 16, right: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SentenceItemContent(sentence: sentence),
          const SizedBox(height: 24),
          SentenceItemEditButton(
            sentence: sentence,
            isShow: false,
          ),
        ]),
      );
    }

    return future.when(
      loading: () => const LoadingSpinner(),
      error: (err, stack) => Text('Error: $err'),
      data: (Sentence? data) => sentence(data),
    );
  }
}
