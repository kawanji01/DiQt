import 'dart:convert';
import 'package:booqs_mobile/widgets/shared/text_with_link.dart';
import 'package:booqs_mobile/widgets/word/word_sentence_search_modal.dart';
import 'package:http/http.dart' as http;
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/widgets/word/word_label.dart';
import 'package:flutter/material.dart';

class SentenceSettingForm extends StatefulWidget {
  const SentenceSettingForm(
      {Key? key, required this.sentenceIdController, required this.keyword})
      : super(key: key);
  final TextEditingController sentenceIdController;
  final String keyword;

  @override
  _SentenceSettingFormState createState() => _SentenceSettingFormState();
}

class _SentenceSettingFormState extends State<SentenceSettingForm> {
  TextEditingController? _sentenceIdController;
  Sentence? _sentence;

  @override
  void initState() {
    super.initState();
    _sentenceIdController = widget.sentenceIdController;
    _loadSentence();
  }

  Future _loadSentence() async {
    final String sentenceId = _sentenceIdController!.text;
    if (sentenceId == 'null' || sentenceId == '') return;

    var url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/api/v1/mobile/sentences/$sentenceId');
    var res =
        await http.get(url, headers: {"Content-Type": "application/json"});
    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    Map<String, dynamic> resMap = json.decode(res.body);
    final Sentence sentence = Sentence.fromJson(resMap['sentence']);
    if (sentence.id == null) return;

    return setState(() {
      _sentence = sentence;
    });
  }

  @override
  Widget build(BuildContext context) {
    // initStateでkeywordをセットすると、WordFormでの再ビルドに対応しない。
    final keyword = widget.keyword;

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
      final String original = _sentence?.original ?? "";
      final String translation = _sentence?.translation ?? "";
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const WordLabel(text: '例文'),
          const SizedBox(height: 8),
          TextWithLink(text: original, autoLinkEnabled: true),
          const SizedBox(height: 8),
          Text(translation,
              style: const TextStyle(
                  fontSize: 16, height: 1.6, color: Colors.black87)),
          const SizedBox(height: 24),
        ],
      );
    }

    //// 例文を設定する ////
    Future _setSentence() async {
      final Sentence? newSentence = await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return WordSentenceSearchModal(keyword: keyword);
        },
      );

      if (newSentence == null) return;

      // 更新
      setState(() {
        // sentence.idがnullなら、設定されている例文を取り消す。
        if (newSentence.id == null) {
          _sentence = null;
          _sentenceIdController!.text = '';
        } else {
          _sentence = newSentence;
          _sentenceIdController!.text = newSentence.id.toString();
        }
      });
    }

    // 設定ボタン
    Widget _settingButton() {
      return SizedBox(
        height: 40,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity,
                40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
          ),
          onPressed: () => {
            _setSentence(),
          },
          icon: const Icon(Icons.settings, color: Colors.white),
          label: const Text(
            '設定する',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      );
    }

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _hiddenField(),
          const SizedBox(height: 24),
          _sentencePreview(),
          _settingButton(),
        ]);
  }
}
