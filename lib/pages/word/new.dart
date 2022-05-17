import 'package:booqs_mobile/data/remote/words.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/pages/home.dart';
import 'package:booqs_mobile/pages/word/show.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/dictionary/name.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:booqs_mobile/widgets/word/form/form.dart';
import 'package:booqs_mobile/widgets/word/form/sentence_setting.dart';
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
  final _meaningController = TextEditingController();
  final _explanationController = TextEditingController();
  final _sentenceIdController = TextEditingController();

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
    _meaningController.text =
        resMap['translation'] == null ? '' : resMap['translation'];
    setState(() {
      _dictionary = dictionary;
      _isLoading;
    });
  }

  // widgetの破棄時にコントローラも破棄する。Controllerを使うなら必ず必要。
  // 参考： https://api.flutter.dev/flutter/widgets/TextEditingController-class.html
  @override
  void dispose() {
    _entryController.dispose();
    _meaningController.dispose();
    _explanationController.dispose();
    _sentenceIdController.dispose();
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
        'meaning': _meaningController.text,
        'explanation': _explanationController.text,
        'sentence_id': _sentenceIdController.text,
        'dictionary_id': _dictionary!.id,
      };
      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      final Map? resMap = await RemoteWords.create(params);
      if (resMap == null) {
        EasyLoading.dismiss();
        const snackBar = SnackBar(content: Text('辞書を更新できませんでした。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final int? wordId = resMap['word']['id'];
        final snackBar = SnackBar(content: Text('${resMap['message']}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        if (wordId == null) return MyHomePage.push(context);
        WordShowPage.pushReplacement(context, wordId);
      }
      // 画面全体のローディングを消す。
      EasyLoading.dismiss();
    }

    // 更新ボタン
    Widget _submitButton() {
      return SizedBox(
        height: 48,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity,
                40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
          ),
          onPressed: () => {
            _create(),
          },
          icon: const Icon(Icons.update, color: Colors.white),
          label: const Text(
            '作成する',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      );
    }

    Widget _body() {
      if (_isLoading) return const LoadingSpinner();
      if (_dictionary == null) return const Text('Dictionary does not exist.');
      return SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(20),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      DictionaryName(dictionary: _dictionary!),
                      WordForm(
                        entryController: _entryController,
                        meaningController: _meaningController,
                        explanationController: _explanationController,
                      ),
                      WordFormSentenceSetting(
                          sentenceIdController: _sentenceIdController,
                          entryController: _entryController,
                          dictionary: _dictionary!),
                      const SizedBox(height: 40),
                      _submitButton(),
                      const SizedBox(height: 40),
                    ]))),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('項目の作成'),
      ),
      body: _body(),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
