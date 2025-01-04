import 'package:booqs_mobile/components/dictionary/name.dart';
import 'package:booqs_mobile/components/sentence/form.dart';
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

class SentenceNewScreen extends StatefulWidget {
  const SentenceNewScreen(
      {super.key,
      required this.originalController,
      required this.translationController,
      required this.explanationController,
      required this.commentController,
      required this.keyword,
      required this.dictionary});
  final TextEditingController originalController;
  final TextEditingController translationController;
  final TextEditingController explanationController;
  final TextEditingController commentController;
  final String keyword;
  final Dictionary dictionary;

  @override
  State<SentenceNewScreen> createState() => _SentenceNewScreenState();
}

class _SentenceNewScreenState extends State<SentenceNewScreen> {
  bool _isRequesting = false;
  // validatorを利用するために必要なkey
  final _formKey = GlobalKey<FormState>();

  Future save() async {
    // 各Fieldのvalidatorを呼び出す
    if (!_formKey.currentState!.validate()) return;
    // リクエストロック開始
    setState(() {
      _isRequesting = true;
    });

    Map<String, dynamic> params = {
      'original': widget.originalController.text,
      'translation': widget.translationController.text,
      'explanation': widget.explanationController.text,
      'dictionary_id': widget.dictionary.id
    };
    // 画面全体にローディングを表示
    EasyLoading.show(status: 'loading...');
    final Map resMap = await RemoteSentences.create(
        params: params, comment: widget.commentController.text);
    EasyLoading.dismiss();
    // リクエストロック終了
    setState(() {
      _isRequesting = false;
    });
    if (!mounted) return;
    if (ErrorHandler.isErrorMap(resMap)) {
      ErrorHandler.showErrorSnackBar(context, resMap);
      return;
    }
    final SentenceRequest sentenceRequest =
        SentenceRequest.fromJson(resMap['sentence_request']);
    final snackBar = SnackBar(content: Text('${resMap['message']}'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    if (sentenceRequest.closed()) {
      final sentence = Sentence.fromJson(resMap['sentence']);
      SentenceShowPage.pushReplacement(context, sentence.id);
    } else {
      SentenceRequestShowPage.pushReplacement(context, sentenceRequest.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DictionaryName(dictionary: widget.dictionary, linked: false),
            const SizedBox(height: 32),
            SentenceForm(
              originalController: widget.originalController,
              translationController: widget.translationController,
              explanationController: widget.explanationController,
              commentController: widget.commentController,
              dictionary: widget.dictionary,
              isNew: true,
              keyword: widget.keyword,
            ),
            const SizedBox(height: 40),
            SizedBox(
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 40),
                ),
                // 二重リクエスト防止
                onPressed: _isRequesting
                    ? null
                    : () async {
                        save();
                      },
                icon: const Icon(Icons.update, color: Colors.white),
                label: Text(
                  t.shared.create,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ]),
    );
  }
}
