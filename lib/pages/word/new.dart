import 'package:booqs_mobile/components/layouts/app_bar/default.dart';
import 'package:booqs_mobile/components/word/new_action_buttons.dart';
import 'package:booqs_mobile/components/word/new_screen.dart';
import 'package:booqs_mobile/data/provider/shared.dart';
import 'package:booqs_mobile/data/remote/words.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordNewPage extends ConsumerStatefulWidget {
  const WordNewPage({super.key});

  static Future push(
      BuildContext context, int dictionaryId, String keyword) async {
    return Navigator.push(
        context,
        MaterialPageRoute(
            // 画面遷移のログを送信するために、settings.nameを設定する。
            settings: RouteSettings(
                name: wordNewPage,
                arguments: {'dictionaryId': dictionaryId, 'keyword': keyword}),
            builder: (BuildContext context) {
              return const WordNewPage();
            },
            fullscreenDialog: true));
  }

  @override
  WordNewPageState createState() => WordNewPageState();
}

class WordNewPageState extends ConsumerState<WordNewPage> {
  Dictionary? _dictionary;
  String keyword = '';
  String translation = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // 複数の引数を受け取る。参考： https://stackoverflow.com/questions/53304340/navigator-pass-arguments-with-pushnamed
    // exeception回避
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 画面遷移を防ぐために、編集中にする。
      ref.read(sharedEditingContentProvider.notifier).onEdit();
      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      _initialize(arguments);
    });
  }

  // キーワードの翻訳を取得する
  Future _initialize(Map arguments) async {
    final int dictionaryId = arguments['dictionaryId'];
    keyword = arguments['keyword'] ?? '';
    final Map resMap = await RemoteWords.newWord(dictionaryId, keyword);
    _isLoading = false;
    if (!mounted) return;
    if (ErrorHandler.isErrorMap(resMap)) {
      ErrorHandler.showErrorSnackBar(context, resMap);
      return setState(() => _isLoading);
    }
    _dictionary = Dictionary.fromJson(resMap['dictionary']);
    translation = resMap['translation'] ?? '';
    setState(() => _isLoading);
  }

  @override
  Widget build(BuildContext context) {
    final NavigatorState navigator = Navigator.of(context);

    Widget body() {
      if (_isLoading) return const LoadingSpinner();
      if (_dictionary == null) {
        return Text(t.shared.no_items_found(name: t.dictionaries.dictionary));
      }
      return WordNewScreen(
          dictionary: _dictionary!, keyword: keyword, translation: translation);
    }

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
      canPop: false, // 戻るキーの動作で戻ることを一旦防ぐ
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        final bool? shouldPop = await showBackDialog(); // ダイアログで戻るか確認
        if (shouldPop == true) {
          navigator.pop(); // 戻るを選択した場合のみpopを明示的に呼ぶ
        }
      },
      child: Scaffold(
        appBar: AppBarDefault(
          title: t.words.add,
          actions: [
            WordNewActionButtons(
              dictionaryId: _dictionary?.id,
            )
          ],
        ),
        body: Container(
          margin: EdgeInsets.symmetric(
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: body(),
        ),
      ),
    );
  }
}
