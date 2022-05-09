import 'package:booqs_mobile/data/remote/sentences.dart';
import 'package:booqs_mobile/widgets/shared/text_with_link.dart';
import 'package:booqs_mobile/widgets/word/sentence_search_modal.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/widgets/word/label.dart';
import 'package:flutter/material.dart';

// 項目の例文設定フォーム。
// 検索条件はentryControllerを利用する
class WordSentenceSettingForm extends StatefulWidget {
  const WordSentenceSettingForm(
      {Key? key,
      required this.sentenceIdController,
      required this.entryController,
      this.dictionaryId})
      : super(key: key);
  final TextEditingController sentenceIdController;
  final TextEditingController entryController;
  final int? dictionaryId;

  @override
  _WordSentenceSettingFormState createState() =>
      _WordSentenceSettingFormState();
}

class _WordSentenceSettingFormState extends State<WordSentenceSettingForm> {
  TextEditingController? _sentenceIdController;
  TextEditingController? _entryController;
  Sentence? _sentence;
  int? _dictionaryId;

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
    final _dictionaryId = widget.dictionaryId;

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
          TextWithLink(
            text: original,
            autoLinkEnabled: true,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
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
          return WordSentenceSearchModal(
              keyword: _entryController!.text, dictionaryId: _dictionaryId);
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
