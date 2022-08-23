import 'package:booqs_mobile/data/remote/sentences.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/widgets/button/small_green_button.dart';
import 'package:booqs_mobile/widgets/word/form/sentence.dart';
import 'package:booqs_mobile/widgets/word/form/sentence_search_modal.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/widgets/word/item/label.dart';
import 'package:flutter/material.dart';

// 項目の例文設定フォーム。
// 検索条件はentryControllerを利用する
class WordFormSentenceSetting extends StatefulWidget {
  const WordFormSentenceSetting(
      {Key? key,
      required this.sentenceIdController,
      required this.entry,
      required this.dictionary})
      : super(key: key);
  final TextEditingController sentenceIdController;
  final String entry;
  final Dictionary dictionary;

  @override
  _WordFormSentenceSettingState createState() =>
      _WordFormSentenceSettingState();
}

class _WordFormSentenceSettingState extends State<WordFormSentenceSetting> {
  TextEditingController? _sentenceIdController;
  final TextEditingController _searchKeywordController =
      TextEditingController(text: '');
  Sentence? _sentence;

  @override
  void initState() {
    super.initState();
    _sentenceIdController = widget.sentenceIdController;
    _searchKeywordController.text = widget.entry;
    _loadSentence();
  }

  @override
  void dispose() {
    _searchKeywordController.dispose();
    super.dispose();
  }

  Future _loadSentence() async {
    final String sentenceId = _sentenceIdController!.text;
    if (sentenceId == 'null' || sentenceId == '') return;
    final Map? resMap = await RemoteSentences.show(int.parse(sentenceId));
    if (resMap == null) return Container();

    final Sentence sentence = Sentence.fromJson(resMap['sentence']);

    return setState(() {
      _sentence = sentence;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dictionary = widget.dictionary;
    // sentenceIDを格納する隠れフィールド
    Widget _hiddenField() {
      return Visibility(
        visible: false,
        child: TextField(
          controller: _sentenceIdController,
          readOnly: true,
        ),
      );
    }

    // 隠しフィールドに設定されている例文の本文と翻訳文のプレビュー
    Widget _sentencePreview() {
      Widget sentenceWidget;
      if (_sentence == null) {
        sentenceWidget = const Text('例文が設定されていません。',
            style: TextStyle(fontSize: 16, height: 1.6, color: Colors.black87));
      } else {
        sentenceWidget = WordFormSentence(sentence: _sentence!);
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const WordItemLabel(text: '例文'),
          const SizedBox(height: 8),
          sentenceWidget,
        ],
      );
    }

    //// 例文を検索して設定する ////
    Future _searchSentence(Dictionary dictionary) async {
      // settingはnullで戻る
      // { 'set': null } で削除
      // { 'set': sentence } で設定
      final Map<String, Sentence?>? setting = await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return WordFormSentenceSearchModal(
              keyword: _searchKeywordController.text, dictionary: dictionary);
        },
      );

      if (setting == null) return;
      // 更新
      setState(() {
        // sentence.idがnullなら、設定されている例文を取り消す。
        if (setting['set'] == null) {
          _sentence = null;
          _sentenceIdController!.text = '';
        } else {
          _sentence = setting['set'];
          _sentenceIdController!.text = _sentence!.id.toString();
        }
      });
    }

    // 設定ボタン
    Widget _settingButton() {
      return Column(children: [
        TextFormField(
          controller: _searchKeywordController,
          style: const TextStyle(color: Colors.black54, fontSize: 14),
          decoration: const InputDecoration(
            labelText: "例文の検索キーワード",
            hintText: '例文を検索するキーワードを入力してください。',
            labelStyle: TextStyle(
              fontSize: 12,
              color: Colors.green,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'キーワードは空欄にできません。';
            }
            return null;
          },
        ),
        InkWell(
          onTap: () {
            _searchSentence(dictionary);
          },
          child: const SmallGreenButton(
            label: '例文を検索する',
            icon: Icons.settings,
          ),
        ),
      ]);
    }

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _hiddenField(),
          const SizedBox(height: 24),
          _sentencePreview(),
          const SizedBox(height: 32),
          _settingButton(),
        ]);
  }
}
