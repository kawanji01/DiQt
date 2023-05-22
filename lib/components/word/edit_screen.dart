import 'package:booqs_mobile/components/dictionary/name.dart';
import 'package:booqs_mobile/components/word/form/destroy_button.dart';
import 'package:booqs_mobile/components/word/form/fields.dart';
import 'package:booqs_mobile/data/provider/word.dart';
import 'package:booqs_mobile/data/remote/words.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/pages/word/show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordEditScreen extends ConsumerStatefulWidget {
  const WordEditScreen(
      {super.key, required this.word, required this.dictionary});
  final Word word;
  final Dictionary dictionary;

  @override
  WordEditScreenState createState() => WordEditScreenState();
}

class WordEditScreenState extends ConsumerState<WordEditScreen> {
  bool _isRequesting = false;
  // validatorを利用するために必要なkey
  final _formKey = GlobalKey<FormState>();
  final _entryController = TextEditingController();
  final _readingController = TextEditingController();
  final _meaningController = TextEditingController();
  final _posTagIdController = TextEditingController();
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
    final Word word = widget.word;
    _entryController.text = word.entry;
    _readingController.text = word.reading ?? '';
    _meaningController.text = word.meaning;
    _posTagIdController.text = word.posTagId.toString();
    _ipaController.text = word.ipa ?? '';
    _etymologiesController.text = word.etymologies ?? '';
    _explanationController.text = word.explanation ?? '';
    _sentenceIdController.text = word.sentenceId.toString();
    _synonymsController.text = word.synonyms ?? '';
    _antonymsController.text = word.antonyms ?? '';
    _relatedController.text = word.related ?? '';
  }

  @override
  // widgetの破棄時にコントローラも破棄する。Controllerを使うなら必ず必要。
  // 参考： https://api.flutter.dev/flutter/widgets/TextEditingController-class.html
  void dispose() {
    _entryController.dispose();
    _readingController.dispose();
    _meaningController.dispose();
    _posTagIdController.dispose();
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
    final Word word = widget.word;
    final Dictionary dictionary = widget.dictionary;

    // 更新処理
    Future save() async {
      // 各Fieldのvalidatorを呼び出す
      if (!_formKey.currentState!.validate()) return;
      setState(() => _isRequesting = true);

      final Map<String, dynamic> params = {
        'id': word.id,
        'entry': _entryController.text,
        'reading': _readingController.text,
        'meaning': _meaningController.text,
        'pos_tag_id': _posTagIdController.text,
        'ipa': _ipaController.text,
        'etymologies': _etymologiesController.text,
        'explanation': _explanationController.text,
        'sentence_id': _sentenceIdController.text,
        'synonyms': _synonymsController.text,
        'antonyms': _antonymsController.text,
        'related_entries': _relatedController.text,
        'dictionary_id': dictionary.id,
      };
      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      final Map? resMap = await RemoteWords.update(params);
      EasyLoading.dismiss();
      setState(() => _isRequesting = false);
      if (!mounted) return;

      if (resMap == null) {
        final snackBar = SnackBar(content: Text(t.words.update_failed));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final Word word = Word.fromJson(resMap['word']);
        ref.read(wordProvider.notifier).state = word;
        final snackBar = SnackBar(content: Text('${resMap['message']}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        WordShowPage.pushReplacement(context, word.id);
      }
    }

    return SingleChildScrollView(
      child: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 24),
                DictionaryName(dictionary: dictionary),
                const SizedBox(height: 32),
                WordFormFields(
                  entryController: _entryController,
                  readingController: _readingController,
                  meaningController: _meaningController,
                  posTagIdController: _posTagIdController,
                  ipaController: _ipaController,
                  etymologiesController: _etymologiesController,
                  explanationController: _explanationController,
                  sentenceIdController: _sentenceIdController,
                  synonymsController: _synonymsController,
                  antonymsController: _antonymsController,
                  relatedController: _relatedController,
                  dictionary: dictionary,
                  word: word,
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
                            save();
                          },
                    icon: const Icon(Icons.update, color: Colors.white),
                    label: Text(
                      t.shared.update,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 64),
                WordFormDestroyButton(word: word),
                const SizedBox(height: 160),
              ])),
    );
  }
}
