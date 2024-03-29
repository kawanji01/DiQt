import 'package:booqs_mobile/components/heading/medium_green.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/components/word/show_screen.dart';
import 'package:booqs_mobile/data/provider/word.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordRequestItemEditTargetScreen extends ConsumerWidget {
  const WordRequestItemEditTargetScreen({super.key, required this.wordRequest});
  final WordRequest wordRequest;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int? wordId = wordRequest.wordId;
    if (wordId == null) {
      return Text(t.wordRequests.target_not_found,
          style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87));
    }
    return ref.watch(asyncWordFamily(wordId)).when(
        data: (word) {
          if (word == null) {
            return Text(t.wordRequests.target_not_found,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87));
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 32,
                ),
                HeadingMediumGreen(
                  label: t.wordRequests.target,
                ),
                const SizedBox(
                  height: 24,
                ),
                WordShowScreen(word: word),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          );
        },
        error: (err, str) => Text('$err, $str'),
        loading: () => const LoadingSpinner());
  }
}
