import 'package:booqs_mobile/data/remote/sentences.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/widgets/button/small_green_button.dart';
import 'package:booqs_mobile/widgets/sentence/item.dart';
import 'package:booqs_mobile/widgets/word/form/sentence_search_modal.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/widgets/word/label.dart';
import 'package:flutter/material.dart';

// 項目の例文設定フォーム。
// 検索条件はentryControllerを利用する
class WordFormSentenceSetting extends StatefulWidget {
  const WordFormSentenceSetting(
      {Key? key,
      required this.sentenceIdController,
      required this.entryController,
      required this.dictionary})
      : super(key: key);
  final TextEditingController sentenceIdController;
  final TextEditingController entryController;
  final Dictionary dictionary;

  @override
  _WordFormSentenceSettingState createState() =>
      _WordFormSentenceSettingState();
}

class _WordFormSentenceSettingState extends State<WordFormSentenceSetting> {
  TextEditingController? _sentenceIdController;
  TextEditingController? _entryController;
  Sentence? _sentence;

  @override
  void initState() {
    super.initState();
    _sentenceIdController = widget.sentenceIdController;
    _entryController = widget.entryController;
    _loadSentence();
  }

  Future _loadSentence() async {
    final String sentenceId = _sentenceIdController!.text;
    if (sentenceId == 'null' || sentenceId == '') return;
    final Map? resMap = await RemoteSentences.show(int.parse(sentenceId));
    if (resMap == null) return Container();

    final Sentence sentence = Sentence.fromJson(resMap['sentence']);
    if (sentence.id == null) return;

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
      if (_sentence == null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            WordLabel(text: '例文'),
            SizedBox(height: 8),
            Text('例文が設定されていません。',
                style: TextStyle(
                    fontSize: 16, height: 1.6, color: Colors.black87)),
            SizedBox(height: 24),
          ],
        );
      }
      return SentenceItem(sentence: _sentence!);
    }

    //// 例文を検索して設定する ////
    Future _searchSentence(String keyword, Dictionary dictionary) async {
      // settingはnullで戻る
      // { 'set': null } で削除
      // { 'set': sentence } で設定
      final Map<String, Sentence?>? setting = await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return WordFormSentenceSearchModal(
              keyword: _entryController!.text, dictionary: dictionary);
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
      return InkWell(
        onTap: () {
          _searchSentence(widget.entryController.text, dictionary);
        },
        child: const SmallGreenButton(
          label: '設定する',
          icon: Icons.settings,
        ),
      );
    }

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _hiddenField(),
          const SizedBox(height: 24),
          _sentencePreview(),
          const SizedBox(height: 16),
          _settingButton(),
        ]);
  }
}
