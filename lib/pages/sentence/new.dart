import 'package:booqs_mobile/components/layouts/app_bar/default.dart';
import 'package:booqs_mobile/components/sentence/new_action_buttons.dart';
import 'package:booqs_mobile/components/sentence/new_screen.dart';
import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceNewPage extends ConsumerStatefulWidget {
  const SentenceNewPage({super.key});

  static Future push(
      BuildContext context, int dictionaryId, String keyword) async {
    return Navigator.push(
        context,
        MaterialPageRoute(
            // 画面遷移のログを送信するために、settings.nameを設定する。
            settings: RouteSettings(
              name: sentenceNewPage,
              arguments: {'dictionaryId': dictionaryId, 'keyword': keyword},
            ),
            builder: (BuildContext context) {
              return const SentenceNewPage();
            },
            fullscreenDialog: true));
  }

  @override
  SentenceNewPageState createState() => SentenceNewPageState();
}

class SentenceNewPageState extends ConsumerState<SentenceNewPage> {
  late String _keyword;
  late int _dictionaryId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    _keyword = arguments['keyword'];
    _dictionaryId = arguments['dictionaryId'];
  }

  @override
  Widget build(BuildContext context) {
    final NavigatorState navigator = Navigator.of(context);

    Future<bool?> showBackDialog() async {
      final bool result = await Dialogs.confirm(
          context: context,
          title: t.shared.return_confirmation,
          message: t.shared.return_confirmation_description);
      if (result) {
        return true; // trueを返すことで画面遷移を許可
      } else {
        return false;
      }
    }

    return PopScope(
      canPop: false, // 戻るキーの動作で戻ることを一旦防ぐ
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (didPop) return;
        final bool? shouldPop = await showBackDialog(); // ダイアログで戻るか確認
        if (shouldPop == true) {
          navigator.pop(); // 戻るを選択した場合のみpopを明示的に呼ぶ
        }
      },
      child: Scaffold(
        appBar: AppBarDefault(
          title: t.sentences.add,
          actions: [
            SentenceNewActionButtons(
              dictionaryId: _dictionaryId,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: ResponsiveValues.horizontalMargin(context)),
              child: ref.watch(asyncDictionaryFamily(_dictionaryId)).when(
                  data: (dictionary) {
                    if (dictionary == null) {
                      return Text(t.shared
                          .no_items_found(name: t.dictionaries.dictionary));
                    }
                    return SentenceNewScreen(
                        keyword: _keyword, dictionary: dictionary);
                  },
                  loading: () => const LoadingSpinner(),
                  error: (err, stack) => Text('$err'))),
        ),
        bottomNavigationBar: const BottomNavbar(),
      ),
    );
  }
}
