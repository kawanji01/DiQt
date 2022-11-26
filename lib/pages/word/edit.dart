import 'package:booqs_mobile/data/provider/word.dart';
import 'package:booqs_mobile/data/remote/words.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/pages/word/show.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/widgets/dictionary/name.dart';
import 'package:booqs_mobile/widgets/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:booqs_mobile/widgets/word/form/destroy_button.dart';
import 'package:booqs_mobile/widgets/word/form/form.dart';
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
  bool _isRequesting = false;
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      final int wordId = arguments['wordId'];
      _loadWord(wordId);
    });
  }

  Future _loadWord(int wordId) async {
    final Map? resMap = await RemoteWords.edit(wordId);
    _isLoading = false;
    if (resMap == null) {
      return setState(() => _isLoading);
    }
    final Word word = Word.fromJson(resMap['word']);
    _entryController.text = word.entry;
    _readingController.text = word.reading ?? '';
    _meaningController.text = word.meaning;
    _ipaController.text = word.ipa ?? '';
    _etymologiesController.text = word.etymologies ?? '';
    _explanationController.text = word.explanation ?? '';
    _sentenceIdController.text = word.sentenceId.toString();
    _synonymsController.text = word.synonyms ?? '';
    _antonymsController.text = word.antonyms ?? '';
    _relatedController.text = word.related ?? '';
    final dictionary = word.dictionary;
    setState(() {
      _word = word;
      _dictionary = dictionary;
      _isLoading;
    });
  }

  @override
  // widgetの破棄時にコントローラも破棄する。Controllerを使うなら必ず必要。
  // 参考： https://api.flutter.dev/flutter/widgets/TextEditingController-class.html
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
    // 更新処理
    Future _save(word) async {
      // 各Fieldのvalidatorを呼び出す
      if (!_formKey.currentState!.validate()) return;
      setState(() => _isRequesting = true);

      final Map<String, dynamic> params = {
        'id': word.id,
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
      final Map? resMap = await RemoteWords.update(params);
      EasyLoading.dismiss();
      setState(() => _isRequesting = false);

      if (resMap == null) {
        const snackBar = SnackBar(content: Text('辞書を更新できませんでした。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final Word word = Word.fromJson(resMap['word']);
        ref.read(wordProvider.notifier).state = word;
        final snackBar = SnackBar(content: Text('${resMap['message']}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        WordShowPage.pushReplacement(context, word.id);
      }
    }

    Widget _body() {
      if (_isLoading) return const LoadingSpinner();
      if (_word == null) return const Text('Word does not exist.');
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
                  // SubmitBtn
                  SizedBox(
                    height: 48,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: const Size(double.infinity,
                            40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
                      ),
                      onPressed: _isRequesting
                          ? null
                          : () async {
                              _save(_word);
                            },
                      icon: const Icon(Icons.update, color: Colors.white),
                      label: const Text(
                        '更新する',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 64),
                  WordFormDestroyButton(word: _word!),
                  const SizedBox(height: 160),
                ])),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${_entryController.text}の編集'),
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
