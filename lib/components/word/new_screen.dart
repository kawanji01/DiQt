import 'package:booqs_mobile/components/word/form/fields.dart';
import 'package:booqs_mobile/data/provider/sense.dart';
import 'package:booqs_mobile/data/provider/word.dart';
import 'package:booqs_mobile/data/remote/words.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:booqs_mobile/pages/word/show.dart';
import 'package:booqs_mobile/pages/word_request/show.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordNewScreen extends ConsumerStatefulWidget {
  const WordNewScreen(
      {super.key,
      required this.dictionary,
      required this.keyword,
      required this.translation});
  final Dictionary dictionary;
  final String keyword;
  final String translation;

  @override
  WordNewScreenState createState() => WordNewScreenState();
}

class WordNewScreenState extends ConsumerState<WordNewScreen> {
  late final wordControllerMapNotifier =
      ref.read(wordControllerMapProvider.notifier);
  bool _isRequesting = false;
  // validatorを利用するために必要なkey
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      wordControllerMapNotifier.initialize(
          dictionaryId: widget.dictionary.id,
          keyword: widget.keyword,
          translation: widget.translation);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      wordControllerMapNotifier.disposeAllItems();
    });
  }

  // 項目の作成
  Future _create() async {
    // 各Fieldのvalidatorを呼び出す
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isRequesting = true);

    Map<String, dynamic> params = wordControllerMapNotifier.requestParams();
    params['senses_attributes'] =
        ref.watch(senseControllerMapListProvider.notifier).requestParams();
    // 画面全体にローディングを表示
    EasyLoading.show(status: 'loading...');
    final Map resMap = await RemoteWords.create(
        params: params, comment: _commentController.text);
    EasyLoading.dismiss();
    setState(() => _isRequesting = false);
    if (!mounted) return;

    if (ErrorHandler.isErrorMap(resMap)) {
      return ErrorHandler.showErrorSnackBar(context, resMap);
    }
    final snackBar = SnackBar(content: Text('${resMap['message']}'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    final WordRequest wordRequest =
        WordRequest.fromJson(resMap['word_request']);
    if (wordRequest.closed()) {
      final Word word = Word.fromJson(resMap['word']);
      ref.read(wordProvider.notifier).state = word;
      WordShowPage.pushReplacement(context, word.id);
    } else {
      WordRequestShowPage.pushReplacement(context, wordRequest.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 24),
                // DictionaryName(dictionary: _dictionary!),
                const SizedBox(height: 32),
                WordFormFields(
                  word: null,
                  dictionary: widget.dictionary,
                  commentController: _commentController,
                ),
                const SizedBox(height: 40),
                // 作成ボタン
                SizedBox(
                  height: 48,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 40),
                    ),
                    onPressed: _isRequesting
                        ? null
                        : () async {
                            _create();
                          },
                    icon: const Icon(Icons.update, color: Colors.white),
                    label: Text(
                      t.shared.create,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ])),
    );
  }
}
