import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/pages/sentence/new.dart';
import 'package:booqs_mobile/widgets/word/form/sentence_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordFormSentenceSearchModal extends ConsumerStatefulWidget {
  const WordFormSentenceSearchModal(
      {Key? key, required this.keyword, required this.dictionary})
      : super(key: key);
  final String keyword;
  final Dictionary dictionary;

  @override
  _WordFormSentenceSearchModalState createState() =>
      _WordFormSentenceSearchModalState();
}

class _WordFormSentenceSearchModalState
    extends ConsumerState<WordFormSentenceSearchModal> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 例文追加ボタン
    Widget _buttonToAddSentence() {
      return SizedBox(
        height: 40,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity,
                40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
          ),
          onPressed: () {
            ref.read(dictionaryProvider.notifier).state = widget.dictionary;
            SentenceNewPage.push(context);
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
    /* Widget _lastList(int index) {
      final lastNumber = _sentences.length - 1;

      if (lastNumber != index) return Container();

      return Column(
        children: <Widget>[
          const SizedBox(height: 40),
          _buttonToAddSentence(),
          const SizedBox(height: 40),
        ],
      );
    } */

    // 検索結果の例文
    /* Widget _buildListRow(BuildContext context, int index) {
      final sentence = _sentences[index];
      final original = sentence.original;
      final translation = sentence.translation;

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
              InkWell(
                  onTap: () {
                    return Navigator.of(context).pop({'set': sentence});
                  },
                  child:
                      const SmallGreenButton(label: '選ぶ', icon: Icons.check)),
              _lastList(index),
            ]),
      );
    } */

    // 検索結果
    /* Widget _searchResults() {
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
 */
    // 例文の取り消しボタン
    Widget _removeButton() {
      return TextButton(
        style: ButtonStyle(
          // paddingを消す
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          minimumSize: MaterialStateProperty.all(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () {
          // 引数に{ 'set': null }を渡すことで、例文を取り消す
          return Navigator.of(context).pop({'set': null});
        },
        child: const Text('例文を取り消す',
            style: TextStyle(
              color: Colors.red,
              fontSize: 12,
            )),
      );
    }

    // ヘッダーの例文の追加ボタン
    Widget _additionButton() {
      return TextButton(
        style: ButtonStyle(
          // paddingを消す
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          minimumSize: MaterialStateProperty.all(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () {
          ref.read(dictionaryProvider.notifier).state = widget.dictionary;
          SentenceNewPage.push(context);
        },
        child: const Text(' / 例文を追加する',
            style: TextStyle(
              color: Colors.green,
              fontSize: 12,
            )),
      );
    }

    // 例文の取り消しボタン
    Widget _heading() {
      return Wrap(children: [
        Text('"${widget.keyword}"の例文 / ', style: const TextStyle(fontSize: 12)),
        _removeButton(),
        _additionButton()
      ]);
    }

    return Container(
      padding: const EdgeInsets.only(top: 8),
      //height: 640,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _heading(),
            const SizedBox(height: 16),
            //_searchResults(),
            WordFormSentenceListView(
                keyword: widget.keyword, dictionary: widget.dictionary),
            _buttonToAddSentence()
          ],
        ),
      ),
    );
  }
}
