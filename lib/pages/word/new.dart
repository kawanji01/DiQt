import 'package:booqs_mobile/components/word/new_screen.dart';
import 'package:booqs_mobile/data/remote/words.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordNewPage extends ConsumerStatefulWidget {
  const WordNewPage({Key? key}) : super(key: key);

  //static Future push(
  //    BuildContext context, int dictionaryId, String keyword) async {
  //  return Navigator.of(context).pushNamed(wordNewPage,
  //      arguments: {'dictionaryId': dictionaryId, 'keyword': keyword});
  //}
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
    Widget body() {
      if (_isLoading) return const LoadingSpinner();
      if (_dictionary == null) {
        return Text(t.shared.no_items_found(name: t.dictionaries.dictionary));
      }
      return WordNewScreen(
          dictionary: _dictionary!, keyword: keyword, translation: translation);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(t.words.add),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
            horizontal: ResponsiveValues.horizontalMargin(context)),
        child: body(),
      ),
    );
  }
}
