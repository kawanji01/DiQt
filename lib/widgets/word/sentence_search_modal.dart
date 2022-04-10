import 'dart:convert';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/utils/booqs_on_web.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WordSentenceSearchModal extends StatefulWidget {
  const WordSentenceSearchModal(
      {Key? key, required this.keyword, required this.dictionaryId})
      : super(key: key);
  final String keyword;
  final int? dictionaryId;

  @override
  _WordSentenceSearchModalState createState() =>
      _WordSentenceSearchModalState();
}

class _WordSentenceSearchModalState extends State<WordSentenceSearchModal> {
  String? _keyword;
  // Sentence? _sentence;
  int? _dictionaryId;
  final List<Sentence> _sentences = [];
  bool _initDone = false;

  @override
  void initState() {
    super.initState();
    _keyword = widget.keyword;
    _dictionaryId = widget.dictionaryId;
    // initStateがcompleteしてから_searchSentences()を実行する。参考：https://stackoverflow.com/questions/56395081/unhandled-exception-inheritfromwidgetofexacttype-localizationsscope-or-inheri
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _searchSentences();
    });
  }

  Future _searchSentences() async {
    var url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/sentences/search');
    var res = await http.post(url,
        body: {'keyword': '$_keyword', 'dictionary_id': '$_dictionaryId'});
    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    Map<String, dynamic> resMap = json.decode(res.body);
    if (resMap['data'] != null) {
      // Convert map to list. ref: https://qiita.com/7_asupara/items/01c29c006556e89f5b17
      resMap['data'].forEach((e) => _sentences.add(Sentence.fromJson(e)));
    }
    return setState(() {
      _keyword;
      _sentences;
      _initDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 例文選択処理
    Future _selectSentence(sentence) async {
      if (sentence != null) {
        Navigator.of(context).pop(sentence);
      } else {
        final removeSentence = Sentence();
        Navigator.of(context).pop(removeSentence);
      }
    }

    // 例文追加ボタン
    Widget _buttonToAddSentence() {
      final String redirectPath = '/sentences/new?dictionary_id=$_dictionaryId';
      return SizedBox(
        height: 40,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity,
                40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
          ),
          onPressed: () => {
            BooQsOnWeb.open(context, redirectPath),
          },
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text(
            '例文を追加する',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      );
    }

    // 最後のリストに表示する例文追加ボタン
    Widget _lastList(int index) {
      final lastNumber = _sentences.length - 1;

      if (lastNumber != index) return Container();

      return Column(
        children: <Widget>[
          const SizedBox(height: 40),
          _buttonToAddSentence(),
          const SizedBox(height: 40),
        ],
      );
    }

    // 検索結果の例文
    Widget _buildListRow(BuildContext context, int index) {
      final sentence = _sentences[index];
      final original = sentence.original ?? '';
      final translation = sentence.translation ?? '';

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(original,
                  style: const TextStyle(
                      fontSize: 16, height: 1.6, color: Colors.black87)),
              const SizedBox(height: 8),
              Text(translation,
                  style: const TextStyle(
                      fontSize: 16, height: 1.6, color: Colors.black87)),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity,
                      40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
                ),
                onPressed: () => {_selectSentence(sentence)},
                icon: const Icon(Icons.check, color: Colors.white),
                label: const Text(
                  '選ぶ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              _lastList(index),
            ]),
      );
    }

    // 検索結果
    Widget _searchResults() {
      if (_sentences.isEmpty) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: <Widget>[
            const Text('例文が見つかりませんでした。',
                style: TextStyle(
                    fontSize: 16, height: 1.6, color: Colors.black87)),
            const SizedBox(height: 40),
            _buttonToAddSentence(),
          ]),
        );
      }

      return Expanded(
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: _buildListRow,
          separatorBuilder: (context, index) => const Divider(),
          itemCount: _sentences.length,
        ),
      );
    }

    // 例文の取り消しボタン
    Widget _statusAndRemoveButton() {
      return Wrap(children: [
        Text('"$_keyword"の例文 / ', style: const TextStyle(fontSize: 12)),
        TextButton(
          style: ButtonStyle(
            // paddingを消す
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            minimumSize: MaterialStateProperty.all(Size.zero),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          // 引数にnullを渡すことで、例文を取り消す
          onPressed: () => _selectSentence(null),
          child: const Text('例文を取り消す',
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              )),
        ),
      ]);
    }

    // 最終的な表示
    Widget _output() {
      if (_initDone == false) return const LoadingSpinner();

      return Container(
        padding: const EdgeInsets.only(top: 8),
        //height: 640,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _statusAndRemoveButton(),
              const SizedBox(height: 16),
              _searchResults(),
            ],
          ),
        ),
      );
    }

    return _output();
  }
}
