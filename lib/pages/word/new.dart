import 'package:booqs_mobile/data/provider/word.dart';
import 'package:booqs_mobile/data/remote/words.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/pages/dictionary/show.dart';
import 'package:booqs_mobile/pages/word/show.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/widgets/dictionary/name.dart';
import 'package:booqs_mobile/widgets/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:booqs_mobile/widgets/word/form/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordNewPage extends ConsumerStatefulWidget {
  const WordNewPage({Key? key}) : super(key: key);

  static Future push(
      BuildContext context, int dictionaryId, String keyword) async {
    return Navigator.of(context).pushNamed(wordNewPage,
        arguments: {'dictionaryId': dictionaryId, 'keyword': keyword});
  }

  @override
  _WordNewPageState createState() => _WordNewPageState();
}

class _WordNewPageState extends ConsumerState<WordNewPage> {
  Dictionary? _dictionary;
  bool _isLoading = true;
  // validatorを利用するために必要なkey
  final _formKey = GlobalKey<FormState>();
  final _entryController = TextEditingController();
  final _readingController = TextEditingController();
  final _meaningController = TextEditingController();
  final _ipaController = TextEditingController();
  final _etymologiesController = TextEditingController();
  final _explanationController = TextEditingController();
  final _sentenceIdController = TextEditingController();
  final _synonymsController = TextEditingController();
  final _antonymsController = TextEditingController();
  final _relatedController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 複数の引数を受け取る。参考： https://stackoverflow.com/questions/53304340/navigator-pass-arguments-with-pushnamed
    // exeception回避
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      _initialize(arguments);
    });
  }

  Future _initialize(Map arguments) async {
    final int dictionaryId = arguments['dictionaryId'];
    final String keyword = arguments['keyword'];
    final Map? resMap = await RemoteWords.newWord(dictionaryId, keyword);
    _isLoading = false;
    if (resMap == null) {
      return setState(() => _isLoading);
    }
    final Dictionary dictionary = Dictionary.fromJson(resMap['dictionary']);
    _entryController.text = keyword;
    _meaningController.text = resMap['translation'] ?? '';
    setState(() {
      _dictionary = dictionary;
      _entryController;
      _meaningController;
      _isLoading;
    });
  }

  // widgetの破棄時にコントローラも破棄する。Controllerを使うなら必ず必要。
  // 参考： https://api.flutter.dev/flutter/widgets/TextEditingController-class.html
  @override
  void dispose() {
    _entryController.dispose();
    _readingController.dispose();
    _meaningController.dispose();
    _ipaController.dispose();
    _etymologiesController.dispose();
    _explanationController.dispose();
    _sentenceIdController.dispose();
    _synonymsController.dispose();
    _antonymsController.dispose();
    _relatedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 項目の作成
    Future _create() async {
      // 各Fieldのvalidatorを呼び出す
      if (!_formKey.currentState!.validate()) return;

      final Map<String, dynamic> params = {
        'entry': _entryController.text,
        'reading': _readingController.text,
        'meaning': _meaningController.text,
        'ipa': _ipaController.text,
        'etymologies': _etymologiesController.text,
        'explanation': _explanationController.text,
        'sentence_id': _sentenceIdController.text,
        'synonyms': _synonymsController.text,
        'antonyms': _antonymsController.text,
        'related_entries': _relatedController.text,
        'dictionary_id': _dictionary!.id,
      };
      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      final Map? resMap = await RemoteWords.create(params);
      EasyLoading.dismiss();
      if (resMap == null) {
        const snackBar = SnackBar(content: Text('辞書を更新できませんでした。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(content: Text('${resMap['message']}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        if (resMap['word'] == null) {
          return DictionaryShowPage.push(context, _dictionary!.id);
        }
        final Word word = Word.fromJson(resMap['word']);
        ref.read(wordProvider.notifier).state = word;
        WordShowPage.pushReplacement(context, word.id);
      }
    }

    Widget _body() {
      if (_isLoading) return const LoadingSpinner();
      if (_dictionary == null) return const Text('Dictionary does not exist.');
      return SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 24),
                  DictionaryName(dictionary: _dictionary!),
                  const SizedBox(height: 32),
                  WordForm(
                    entryController: _entryController,
                    readingController: _readingController,
                    meaningController: _meaningController,
                    ipaController: _ipaController,
                    etymologiesController: _etymologiesController,
                    explanationController: _explanationController,
                    sentenceIdController: _sentenceIdController,
                    synonymsController: _synonymsController,
                    antonymsController: _antonymsController,
                    relatedController: _relatedController,
                    dictionary: _dictionary!,
                  ),
                  const SizedBox(height: 40),
                  // 作成ボタン
                  SizedBox(
                    height: 48,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        minimumSize: const Size(double.infinity,
                            40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
                      ),
                      onPressed: () => {
                        _create(),
                      },
                      icon: const Icon(Icons.update, color: Colors.white),
                      label: const Text(
                        '作成する',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ])),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('項目の作成'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
            horizontal: ResponsiveValues.horizontalMargin(context)),
        child: _body(),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
