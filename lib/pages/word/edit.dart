import 'package:booqs_mobile/data/remote/words.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/pages/word/show.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/dictionary/icon.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:booqs_mobile/widgets/word/form/form.dart';
import 'package:booqs_mobile/widgets/word/form/sentence_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordEditPage extends ConsumerStatefulWidget {
  const WordEditPage({Key? key}) : super(key: key);

  static Future push(BuildContext context, int wordId) async {
    return Navigator.of(context)
        .pushNamed(wordEditPage, arguments: {'wordId': wordId});
  }

  @override
  _WordEditPageState createState() => _WordEditPageState();
}

class _WordEditPageState extends ConsumerState<WordEditPage> {
  Word? _word;
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
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      final int wordId = arguments['wordId'];
      _loadWord(wordId);
    });
  }

  Future _loadWord(int wordId) async {
    final Map? resMap = await RemoteWords.edit(wordId);
    if (resMap == null) return;
    final Word word = Word.fromJson(resMap['word']);
    _entryController.text = word.entry;
    _meaningController.text = word.meaning;
    _explanationController.text = word.explanation ?? '';
    _sentenceIdController.text = word.sentenceId.toString();
    final dictionary = word.dictionary;
    setState(() {
      _word = word;
      _dictionary = dictionary;
      _isLoading = false;
    });
  }

  @override
  // widgetの破棄時にコントローラも破棄する。Controllerを使うなら必ず必要。
  // 参考： https://api.flutter.dev/flutter/widgets/TextEditingController-class.html
  void dispose() {
    _entryController.dispose();
    _meaningController.dispose();
    _explanationController.dispose();
    _sentenceIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    Future _save(word) async {
      // 各Fieldのvalidatorを呼び出す
      if (!_formKey.currentState!.validate()) return;

      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');

      final Map<String, dynamic> params = {
        'id': word.id,
        'entry': _entryController.text,
        'meaning': _meaningController.text,
        'explanation': _explanationController.text,
        'sentence_id': _sentenceIdController.text,
        'dictionary_id': _dictionary!.id,
      };

      final Map? resMap = await RemoteWords.update(params);

      if (resMap == null) {
        EasyLoading.dismiss();
        const snackBar = SnackBar(content: Text('辞書を更新できませんでした。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final int wordId = resMap['word']['id'];
        final snackBar = SnackBar(content: Text('${resMap['message']}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        WordShowPage.pushReplacement(context, wordId);
      }
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
            _save(_word),
          },
          icon: const Icon(Icons.update, color: Colors.white),
          label: const Text(
            '更新する',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      );
    }

    Widget _body() {
      if (_isLoading) return const LoadingSpinner();
      if (_word == null) return const Text('Word does not exist.');
      if (_dictionary == null) return const Text('Dictionary does not exist.');
      return SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(20),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      DictionaryIcon(dictionary: _dictionary!),
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
        title: Text('${_entryController.text}の編集'),
      ),
      body: _body(),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
