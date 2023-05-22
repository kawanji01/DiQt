import 'package:booqs_mobile/components/sentence/edit_screen.dart';
import 'package:booqs_mobile/data/provider/sentence.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceEditPage extends ConsumerWidget {
  const SentenceEditPage({super.key});

  static Future push(BuildContext context, int sentenceId) async {
    return Navigator.of(context)
        .pushNamed(sentenceEditPage, arguments: {'sentenceId': sentenceId});
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final int sentenceId = arguments['sentenceId'];

    return Scaffold(
      appBar: AppBar(
        title: Text(t.sentences.edit),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
            vertical: 24,
            horizontal: ResponsiveValues.horizontalMargin(context)),
        child: ref.watch(asyncSentenceFamily(sentenceId)).when(
            data: (Sentence? sentence) {
              if (sentence == null) {
                return const Text('Sentence does not exist.');
              }
              final Dictionary? dictionary = sentence.dictionary;
              if (dictionary == null) {
                return const Text('Dictionary does not exist.');
              }
              return SentenceEditScreen(
                sentence: sentence,
                dictionary: dictionary,
              );
            },
            error: (err, str) => Text('Errors: $err'),
            loading: () => const LoadingSpinner()),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
