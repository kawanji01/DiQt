import 'package:booqs_mobile/components/word/form/destroy_button.dart';
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

class WordEditScreen extends ConsumerStatefulWidget {
  const WordEditScreen(
      {super.key, required this.word, required this.dictionary});
  final Word word;
  final Dictionary dictionary;

  @override
  WordEditScreenState createState() => WordEditScreenState();
}

class WordEditScreenState extends ConsumerState<WordEditScreen> {
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
          dictionaryId: widget.dictionary.id, word: widget.word);
      ref.read(editWordProvider.notifier).state = widget.word;
      ref.read(editWordDictionaryProvider.notifier).state = widget.dictionary;
      setState(() {});
    });
  }

  @override
  // widgetの破棄時にコントローラも破棄する。Controllerを使うなら必ず必要。
  // 参考： https://api.flutter.dev/flutter/widgets/TextEditingController-class.html
  void dispose() {
    super.dispose();
    _commentController.dispose();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      wordControllerMapNotifier.disposeAllItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    // 更新処理
    Future save() async {
      // 各Fieldのvalidatorを呼び出す
      if (!_formKey.currentState!.validate()) return;
      setState(() => _isRequesting = true);

      Map<String, dynamic> params = wordControllerMapNotifier.requestParams();
      Map<String, dynamic> senseParams =
          ref.watch(senseControllerMapListProvider.notifier).requestParams();
      print('${senseParams}');
      params['senses_attributes'] = senseParams;
      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      final Map resMap = await RemoteWords.update(
          params: params, comment: _commentController.text);
      EasyLoading.dismiss();
      setState(() => _isRequesting = false);
      if (!mounted) return;

      if (ErrorHandler.isErrorMap(resMap)) {
        return ErrorHandler.showErrorSnackBar(context, resMap);
      }
      final Word updatedWord = Word.fromJson(resMap['word']);
      final WordRequest wordRequest =
          WordRequest.fromJson(resMap['word_request']);

      if (wordRequest.closed()) {
        ref.read(wordProvider.notifier).state = updatedWord;
        WordShowPage.pushReplacement(context, updatedWord.id);
      } else {
        WordRequestShowPage.pushReplacement(context, wordRequest.id);
      }
      final snackBar = SnackBar(content: Text('${resMap['message']}'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return SingleChildScrollView(
      child: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 24),
                // DictionaryName(dictionary: _dictionary),
                const SizedBox(height: 32),
                WordFormFields(
                  word: widget.word,
                  dictionary: widget.dictionary,
                  commentController: _commentController,
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
                    icon: const Icon(Icons.edit, color: Colors.white),
                    label: Text(
                      t.shared.update,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 64),
                WordFormDestroyButton(
                  word: widget.word,
                  commentController: _commentController,
                ),
                const SizedBox(height: 160),
              ])),
    );
  }
}
