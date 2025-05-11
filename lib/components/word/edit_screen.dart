import 'package:booqs_mobile/components/dictionary/name.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/components/word/form/destroy_button.dart';
import 'package:booqs_mobile/components/word/form/fields.dart';
import 'package:booqs_mobile/data/provider/grammatical_tag.dart';
import 'package:booqs_mobile/data/provider/sense.dart';
import 'package:booqs_mobile/data/provider/shared.dart';
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
  bool _isLoading = true;
  // validatorを利用するために必要なkey
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // wordのフォーム用のコントローラーをセットする。
      wordControllerMapNotifier.initialize(
          dictionaryId: widget.dictionary.id, word: widget.word);
      // Wordの親の辞書を設定。
      ref.read(wordEditDictionaryProvider.notifier).state = widget.dictionary;
      // 文法タグの選択状態を初期化する
      if (widget.word.grammaticalTags != null) {
        final ids = widget.word.grammaticalTags!.map((tag) => tag.id).toList();
        ref.read(grammaticalTagIdsProvider.notifier).state = ids;
      } else {
        ref.read(grammaticalTagIdsProvider.notifier).state = [];
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  // widgetの破棄時にコントローラも破棄する。Controllerを使うなら必ず必要。
  // 参考： https://api.flutter.dev/flutter/widgets/TextEditingController-class.html
  void dispose() {
    super.dispose();
    _commentController.dispose();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // メモリリークを防ぐために、すべてのControllerを破棄する。
      wordControllerMapNotifier.disposeAllItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    // initStateが終わる前にWordFormFieldsを描画してしまうと、wordControllerMapNotifier.initializeが終わる前にフォームが描画されることで例文が表示されなくなる。
    if (_isLoading) {
      return const LoadingSpinner();
    }

    // 更新処理
    Future save() async {
      // 各Fieldのvalidatorを呼び出す
      if (!_formKey.currentState!.validate()) return;
      final Map<String, dynamic> params =
          wordControllerMapNotifier.requestParams();
      final String sentenceId = params['sentence_id'];
      // 例文の設定が必須な場合には、スナックバーでエラーメッセージを表示する
      if (widget.dictionary.sentenceRequired && sentenceId == '') {
        final snackBar = SnackBar(content: Text(t.words.sentence_required));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }

      setState(() => _isRequesting = true);

      Map<String, dynamic> senseParams =
          ref.watch(senseControllerMapListProvider.notifier).requestParams();
      params['senses_attributes'] = senseParams;
      // 文法タグのパラメーターを追加する
      final grammaticalTagIds = ref.watch(grammaticalTagIdsProvider);
      params['new_grammatical_tag_ids'] = grammaticalTagIds;
      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      final Map resMap = await RemoteWords.update(
          params: params, comment: _commentController.text);
      EasyLoading.dismiss();
      setState(() => _isRequesting = false);
      if (!context.mounted) return;

      if (ErrorHandler.isErrorMap(resMap)) {
        return ErrorHandler.showErrorSnackBar(context, resMap);
      }
      final Word updatedWord = Word.fromJson(resMap['word']);
      final WordRequest wordRequest =
          WordRequest.fromJson(resMap['word_request']);
      // 編集状態を解除
      ref.read(sharedEditingContentProvider.notifier).offEdit();
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
                DictionaryName(dictionary: widget.dictionary, linked: false),
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
                      foregroundColor: Colors.white,
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
                ),
                const SizedBox(height: 160),
              ])),
    );
  }
}
