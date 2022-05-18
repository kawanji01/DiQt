import 'package:booqs_mobile/pages/sentence/new.dart';
import 'package:booqs_mobile/utils/ad/app_banner.dart';
import 'package:booqs_mobile/widgets/button/small_outline_gray_button.dart';
import 'package:flutter/material.dart';

class DictionaryNoSentencesFound extends StatelessWidget {
  const DictionaryNoSentencesFound(
      {Key? key, required this.dictionaryId, required this.keyword})
      : super(key: key);
  final int dictionaryId;
  final String keyword;

  @override
  Widget build(BuildContext context) {
    // 例文の新規作成ボタン
    Widget _newSentenceButton() {
      return InkWell(
        onTap: () {
          SentenceNewPage.push(context, dictionaryId);
        },
        child: const SmallOutlineGrayButton(label: '例文を追加する', icon: Icons.add),
      );
    }

    return Column(
      children: <Widget>[
        const SizedBox(height: 48),
        Text(
          '"$keyword"が含まれる例文がありません。',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 40),
        _newSentenceButton(),
        const SizedBox(height: 80),
        const AppBanner(),
      ],
    );
  }
}
