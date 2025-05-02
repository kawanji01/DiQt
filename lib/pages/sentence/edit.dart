import 'package:booqs_mobile/components/layouts/app_bar/default.dart';
import 'package:booqs_mobile/components/sentence/edit_action_buttons.dart';
import 'package:booqs_mobile/components/sentence/edit_screen.dart';
import 'package:booqs_mobile/data/provider/sentence.dart';
import 'package:booqs_mobile/data/provider/shared.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceEditPage extends ConsumerWidget {
  const SentenceEditPage({super.key});

  static Future push(BuildContext context, int sentenceId) async {
    return Navigator.push(
        context,
        MaterialPageRoute(
            // 画面遷移のログを送信するために、settings.nameを設定する。
            settings: RouteSettings(
              name: sentenceEditPage,
              arguments: {'sentenceId': sentenceId},
            ),
            builder: (BuildContext context) {
              return const SentenceEditPage();
            },
            fullscreenDialog: true));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final int sentenceId = arguments['sentenceId'];
    final NavigatorState navigator = Navigator.of(context);

    Future<bool?> showBackDialog() async {
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
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (didPop) return;
        final bool? shouldPop = await showBackDialog();
        if (shouldPop == true) {
          ref.read(sharedEditingContentProvider.notifier).offEdit();
          navigator.pop();
        }
      },
      child: Scaffold(
        appBar: AppBarDefault(
          title: t.sentences.edit,
          actions: [SentenceEditActionButtons(sentenceId: sentenceId)],
        ),
        body: Container(
          margin: EdgeInsets.symmetric(
              vertical: 24,
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: ref.watch(asyncSentenceFamily(sentenceId)).when(
              data: (Sentence? sentence) {
                if (sentence == null) {
                  return Text(
                      t.shared.no_items_found(name: t.sentences.sentence));
                }
                final Dictionary? dictionary = sentence.dictionary;
                if (dictionary == null) {
                  return Text(
                      t.shared.no_items_found(name: t.dictionaries.dictionary));
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
      ),
    );
  }
}
