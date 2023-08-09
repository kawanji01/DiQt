import 'package:booqs_mobile/components/word/edit_screen.dart';
import 'package:booqs_mobile/data/provider/word.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordEditPage extends ConsumerWidget {
  const WordEditPage({super.key});

  static Future push(BuildContext context, int wordId) async {
    return Navigator.push(
        context,
        MaterialPageRoute(
            // 画面遷移のログを送信するために、settings.nameを設定する。
            settings: RouteSettings(
              name: wordEditPage,
              arguments: {'wordId': wordId},
            ),
            builder: (BuildContext context) {
              return const WordEditPage();
            },
            fullscreenDialog: true));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final int wordId = arguments['wordId'];
    return Scaffold(
      appBar: AppBar(
        title: Text(t.words.edit),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
            horizontal: ResponsiveValues.horizontalMargin(context)),
        child: ref.watch(asyncWordFamily(wordId)).when(
            data: (Word? word) {
              if (word == null) return const Text('Word does not exist.');
              final Dictionary? dictionary = word.dictionary;
              if (dictionary == null) {
                return const Text('Dictionary does not exist.');
              }
              return WordEditScreen(word: word, dictionary: dictionary);
            },
            error: (err, str) => Text('Errors: $err'),
            loading: () => const LoadingSpinner()),
      ),
    );
  }
}
