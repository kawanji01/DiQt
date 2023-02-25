import 'package:booqs_mobile/components/sentence/item/content.dart';
import 'package:booqs_mobile/components/sentence/setting_form/search_modal.dart';
import 'package:booqs_mobile/data/remote/sentences.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/components/button/small_green_button.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/components/word/item/label.dart';
import 'package:flutter/material.dart';

// 項目の例文設定フォーム。
// 検索条件はentryControllerを利用する
class SentenceSettingForm extends StatefulWidget {
  const SentenceSettingForm(
      {Key? key,
      required this.sentenceIdController,
      required this.keyword,
      required this.dictionary})
      : super(key: key);
  final TextEditingController sentenceIdController;
  final String keyword;
  final Dictionary dictionary;

  @override
  createState() => _SentenceSettingFormState();
}

class _SentenceSettingFormState extends State<SentenceSettingForm> {
  TextEditingController? _sentenceIdController;
  final TextEditingController _searchKeywordController =
      TextEditingController(text: '');
  Sentence? _sentence;

  @override
  void initState() {
    super.initState();
    _sentenceIdController = widget.sentenceIdController;
    _searchKeywordController.text = widget.keyword;
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
    Widget hiddenField() {
      return Visibility(
        visible: false,
        child: TextField(
          controller: _sentenceIdController,
          readOnly: true,
        ),
      );
    }

    // 隠しフィールドに設定されている例文の本文と翻訳文のプレビュー
    Widget sentencePreview() {
      Widget sentenceWidget;
      if (_sentence == null) {
        sentenceWidget = const Text('例文が設定されていません。',
            style: TextStyle(fontSize: 16, height: 1.6, color: Colors.black87));
      } else {
        sentenceWidget = SentenceItemContent(sentence: _sentence!);
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
    Future searchSentence(Dictionary dictionary) async {
      // settingはnullで戻る
      // { 'set': null } で削除
      // { 'set': sentence } で設定
      final Map<String, Sentence?>? setting = await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SentenceSettingFormSearchModal(
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
    Widget settingButton() {
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
        ),
        InkWell(
          onTap: () {
            searchSentence(dictionary);
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
          hiddenField(),
          const SizedBox(height: 24),
          sentencePreview(),
          const SizedBox(height: 32),
          settingButton(),
        ]);
  }
}
