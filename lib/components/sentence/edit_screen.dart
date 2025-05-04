import 'package:booqs_mobile/components/dictionary/name.dart';
import 'package:booqs_mobile/components/sentence/form.dart';
import 'package:booqs_mobile/components/sentence/form/destroy_button.dart';
import 'package:booqs_mobile/data/remote/sentences.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/sentence_request.dart';
import 'package:booqs_mobile/pages/sentence/show.dart';
import 'package:booqs_mobile/pages/sentence_request/show.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SentenceEditScreen extends StatefulWidget {
  const SentenceEditScreen(
      {super.key, required this.sentence, required this.dictionary});
  final Sentence sentence;
  final Dictionary dictionary;

  @override
  State<SentenceEditScreen> createState() => _SentenceEditScreenState();
}

class _SentenceEditScreenState extends State<SentenceEditScreen> {
  bool _isRequesting = false;
  // validatorを利用するために必要なkey
  final _formKey = GlobalKey<FormState>();
  final _originalController = TextEditingController();
  final _originalSsmlController = TextEditingController();
  final _translationController = TextEditingController();
  final _explanationController = TextEditingController();
  final _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final Sentence sentence = widget.sentence;
    _originalController.text = sentence.original;
    _originalSsmlController.text = sentence.originalSsml ?? '';
    _translationController.text = sentence.translation;
    _explanationController.text = sentence.explanation ?? '';
  }

  @override
  // widgetの破棄時にコントローラも破棄する。Controllerを使うなら必ず必要。
  // 参考： https://api.flutter.dev/flutter/widgets/TextEditingController-class.html
  void dispose() {
    _originalController.dispose();
    _translationController.dispose();
    _originalSsmlController.dispose();
    _explanationController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Sentence sentence = widget.sentence;
    final Dictionary dictionary = widget.dictionary;

    // 更新処理
    Future save() async {
      // 各Fieldのvalidatorを呼び出す
      if (!_formKey.currentState!.validate()) return;
      setState(() {
        _isRequesting = true;
      });

      Map<String, dynamic> params = {
        'id': sentence.id,
        'original': _originalController.text,
        'original_ssml': _originalSsmlController.text,
        'translation': _translationController.text,
        'explanation': _explanationController.text
      };
      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      final Map resMap = await RemoteSentences.update(
          params: params, comment: _commentController.text);
      EasyLoading.dismiss();
      setState(() {
        _isRequesting = false;
      });
      if (!context.mounted) return;
      if (ErrorHandler.isErrorMap(resMap)) {
        ErrorHandler.showErrorSnackBar(context, resMap);
        return;
      }
      final SentenceRequest sentenceRequest =
          SentenceRequest.fromJson(resMap['sentence_request']);
      if (sentenceRequest.closed()) {
        final sentence = Sentence.fromJson(resMap['sentence']);
        final snackBar = SnackBar(content: Text(t.sentences.updated));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        SentenceShowPage.pushReplacement(context, sentence.id);
      } else {
        final snackBar = SnackBar(content: Text(resMap['message']));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        SentenceRequestShowPage.pushReplacement(context, sentenceRequest.id);
      }
    }

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DictionaryName(dictionary: dictionary, linked: false),
              const SizedBox(height: 32),
              SentenceForm(
                originalController: _originalController,
                originalSsmlController: _originalSsmlController,
                translationController: _translationController,
                explanationController: _explanationController,
                commentController: _commentController,
                dictionary: sentence.dictionary!,
                isNew: false,
                keyword: '',
              ),
              const SizedBox(height: 40),
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
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 64),
              SentenceFormDestroyButton(sentence: sentence),
              const SizedBox(height: 160),
            ]),
      ),
    );
  }
}
