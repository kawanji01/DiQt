import 'package:booqs_mobile/widgets/word/sentence_setting_form.dart';
import 'package:flutter/material.dart';

class WordForm extends StatefulWidget {
  const WordForm({
    Key? key,
    required this.entryController,
    required this.meaningController,
    required this.explanationController,
    required this.sentenceIdController,
    required this.dictionaryId,
  }) : super(key: key);

  final TextEditingController entryController;
  final TextEditingController meaningController;
  final TextEditingController explanationController;
  final TextEditingController sentenceIdController;
  final int? dictionaryId;

  @override
  _WordFormState createState() => _WordFormState();
}

class _WordFormState extends State<WordForm> {
  TextEditingController? _entryController;
  TextEditingController? _meaningController;
  TextEditingController? _explanationController;
  TextEditingController? _sentenceIdController;
  String? _keyword;
  int? _dictionaryId;

  @override
  void initState() {
    super.initState();
    _entryController = widget.entryController;
    _meaningController = widget.meaningController;
    _explanationController = widget.explanationController;
    _sentenceIdController = widget.sentenceIdController;
    _keyword = _entryController!.text;
    _dictionaryId = widget.dictionaryId;
  }

  @override
  Widget build(BuildContext context) {
    // initState経由で_keywordを設定するとなぜか空欄になるので、BuildContextでも再設定する。
    if (_keyword == '') {
      _keyword = _entryController!.text;
    }
    _dictionaryId ??= widget.dictionaryId;
    print('word-form-dictionary_id: $_dictionaryId');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // 項目フォーム
        TextFormField(
          controller: _entryController,
          decoration: const InputDecoration(
              labelText: "項目名", hintText: '項目名を入力してください。'),
          validator: (value) {
            if (value!.isEmpty) {
              return '項目名は空欄にできません。';
            }
            return null;
          },
          // 項目フォームを書き換えるたびにkeywordを変更することで、項目に応じた例文検索を機能させる。参考： https://sugitlab.github.io/FlutterJapan_LT_FormWidgetDeepDive/28?clicks=1
          // WordForm以下すべてが再ビルドされてしまうので、他にもっと良い方法があるなら採用したい。
          onChanged: (value) => {
            setState(() => _keyword = value),
          },
        ),
        const SizedBox(height: 24),
        // 意味フォーム
        TextFormField(
          controller: _meaningController,
          decoration: const InputDecoration(
              labelText: "主な意味", hintText: '主な意味を入力してください。'),
          validator: (value) {
            if (value!.isEmpty) {
              return '意味は空欄にできません。';
            }
            return null;
          },
        ),
        const SizedBox(height: 40),
        // 解説フォーム
        TextFormField(
          // 複数行のフォーム。 参考： https://stackoverflow.com/questions/54972928/how-to-expand-a-textfield-in-flutter-looks-like-a-text-area
          minLines: 8,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: _explanationController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: '解説',
            hintText: '【空欄可】解説があれば入力してください。',
          ),
        ),
        SentenceSettingForm(
            sentenceIdController: _sentenceIdController!,
            keyword: _keyword!,
            dictionaryId: _dictionaryId),
      ],
    );
  }
}
