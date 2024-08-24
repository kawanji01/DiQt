import 'package:booqs_mobile/components/layouts/app_bar/default.dart';
import 'package:booqs_mobile/components/word/edit_screen.dart';
import 'package:booqs_mobile/data/provider/shared.dart';
import 'package:booqs_mobile/data/provider/word.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordEditPage extends ConsumerStatefulWidget {
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
  ConsumerState<WordEditPage> createState() => WordEditPageState();
}

class WordEditPageState extends ConsumerState<WordEditPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 画面遷移を防ぐために、編集中にする。
      ref.read(sharedEditingContentProvider.notifier).onEdit();
    });
  }

  /* @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 画面遷移を許可するために、編集中を解除する。
      ref.read(sharedEditingContentProvider.notifier).offEdit();
    });
  } */

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final int wordId = arguments['wordId'];
    return WillPopScope(
      onWillPop: () async {
        final bool result = await Dialogs.confirm(
            context: context,
            title: t.shared.return_confirmation,
            message: t.shared.return_confirmation_description);
        if (result) {
          // 画面遷移を許可するために、編集中を解除する。
          ref.read(sharedEditingContentProvider.notifier).offEdit();
          return true; // trueを返すことで画面遷移を許可
        } else {
          return false;
        }
      },
      child: Scaffold(
        appBar: AppBarDefault(
          title: t.words.edit,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: ref.watch(asyncWordFamily(wordId)).when(
              data: (Word? word) {
                if (word == null) {
                  return Text(t.shared.no_items_found(name: t.words.word));
                }
                final Dictionary? dictionary = word.dictionary;
                if (dictionary == null) {
                  return Text(
                      t.shared.no_items_found(name: t.dictionaries.dictionary));
                }
                return WordEditScreen(word: word, dictionary: dictionary);
              },
              error: (err, str) => Text('Errors: $err'),
              loading: () => const LoadingSpinner()),
        ),
      ),
    );
  }
}
