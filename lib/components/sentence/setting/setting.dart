import 'package:booqs_mobile/components/button/small_outline_green_button.dart';
import 'package:booqs_mobile/components/sentence/setting/search_screen.dart';
import 'package:booqs_mobile/components/sentence/setting/generator_screen.dart';
import 'package:booqs_mobile/components/sentence/setting/sentence_preview.dart';
import 'package:booqs_mobile/data/remote/sentences.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter/material.dart';

// 項目の例文設定フォーム。
// 検索条件はentryControllerを利用する
class SentenceSetting extends StatefulWidget {
  const SentenceSetting(
      {Key? key,
      required this.sentenceIdController,
      required this.entry,
      required this.posTagIdController,
      required this.dictionary})
      : super(key: key);
  final TextEditingController sentenceIdController;
  final String entry;
  final TextEditingController posTagIdController;
  final Dictionary dictionary;

  @override
  SentenceSettingState createState() => SentenceSettingState();
}

class SentenceSettingState extends State<SentenceSetting> {
  late TextEditingController _sentenceIdController;
  final TextEditingController _keywordController = TextEditingController();
  final _meaningController = TextEditingController(text: '');
  final _sentenceTypeController = TextEditingController(text: '');
  final _difficultyController = TextEditingController(text: '');
  final _keepingFormController = TextEditingController(text: '');
  final _aiModelController = TextEditingController(text: '3');
  final _temperatureController = TextEditingController(text: '7');
  Sentence? _sentence;

  @override
  void initState() {
    super.initState();
    _sentenceIdController = widget.sentenceIdController;
    _keywordController.text = widget.entry;
    _loadSentence();
  }

  @override
  void dispose() {
    _keywordController.dispose();
    _meaningController.dispose();
    _sentenceTypeController.dispose();
    _difficultyController.dispose();
    _keepingFormController.dispose();
    _aiModelController.dispose();
    _temperatureController.dispose();
    super.dispose();
  }

  Future _loadSentence() async {
    final String sentenceId = _sentenceIdController.text;
    if (sentenceId == 'null' || sentenceId == '') return;
    final Map resMap = await RemoteSentences.show(int.parse(sentenceId));
    if (!mounted) return;
    if (ErrorHandler.isErrorMap(resMap)) {
      ErrorHandler.showErrorSnackBar(context, resMap);
      return;
    }
    final Sentence sentence = Sentence.fromJson(resMap['sentence']);
    return setState(() {
      _sentence = sentence;
    });
  }

  //// 例文を生成して設定する ////
  Future _generateSentence() async {
    // ボタンを押したときのTextFieldのフォーカスが解除する。
    // これをしないとモーダルを閉じたときに、画面がTextFieldまで移動してしまい不便。
    FocusScope.of(context).unfocus();
    // settingは null で戻る
    // { 'set': null } で 削除
    // { 'set': sentence } で 設定
    final Map<String, Sentence?>? setting = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SentenceSettingGeneratorScreen(
          keywordController: _keywordController,
          posTagIdController: widget.posTagIdController,
          meaningController: _meaningController,
          sentenceTypeController: _sentenceTypeController,
          difficultyController: _difficultyController,
          keepingFormController: _keepingFormController,
          aiModelController: _aiModelController,
          temperatureController: _temperatureController,
          dictionary: widget.dictionary,
        );
      },
    );

    if (setting == null) return;
    // 更新
    _setSentence(setting);
  }

  //// 例文を検索して設定する ////
  Future _searchSentence() async {
    FocusScope.of(context).unfocus();
    final Map<String, Sentence?>? setting = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SentenceSettingSearchScreen(
            keyword: _keywordController.text, dictionary: widget.dictionary);
      },
    );
    // 更新
    _setSentence(setting);
  }

  // 更新
  void _setSentence(Map<String, Sentence?>? setting) {
    if (setting == null) return;
    setState(() {
      // sentence.idがnullなら、設定されている例文を取り消す。
      if (setting['set'] == null) {
        _sentence = null;
        _sentenceIdController.text = '';
      } else {
        _sentence = setting['set'];
        _sentenceIdController.text = _sentence!.id.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 例文生成ボタン
    Widget generateButton() {
      return InkWell(
          onTap: () => _generateSentence(),
          child: SmallOutlineGreenButton(
              label: t.sentences.generate_sentence, icon: Icons.auto_fix_high));
    }

    // 例文検索ボタン
    Widget searchButton() {
      return SizedBox(
        height: 46.0, // You can adjust the height value as per your need.
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            child: TextFormField(
              controller: _keywordController,
              style: const TextStyle(color: Colors.black87, fontSize: 16),
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                labelText: t.words.search_sentence,
                hintText: t.words.search_sentence_placeholder,
                fillColor: const Color(0xfff3f3f4),
                filled: true,
                labelStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
            child: const Icon(
              Icons.search,
              color: Colors.white,
              size: 28,
            ),
            onPressed: () => _searchSentence(),
          ),
        ]),
      );
    }

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 24),
          SentenceSettingSentencePreview(sentence: _sentence),
          const SizedBox(height: 32),
          generateButton(),
          const SizedBox(height: 32),
          searchButton(),
        ]);
  }
}
