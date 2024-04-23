import 'package:booqs_mobile/components/heading/medium_green.dart';
import 'package:booqs_mobile/components/sentence/show_screen.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/data/provider/sentence.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/sentence_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceRequestItemEditTargetScreen extends ConsumerWidget {
  const SentenceRequestItemEditTargetScreen(
      {super.key, required this.sentenceRequest});
  final SentenceRequest sentenceRequest;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int? sentenceId = sentenceRequest.sentenceId;
    if (sentenceId == null) {
      return Text(t.wordRequests.target_not_found,
          style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87));
    }
    return ref.watch(asyncSentenceFamily(sentenceId)).when(
        data: (sentence) {
          if (sentence == null) {
            return Text(t.wordRequests.target_not_found,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87));
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                HeadingMediumGreen(
                  label: t.wordRequests.target,
                ),
                const SizedBox(
                  height: 24,
                ),
                SentenceShowScreen(sentence: sentence),
              ],
            ),
          );
        },
        error: (err, str) => Text('$err'),
        loading: () => const LoadingSpinner());
  }
}
