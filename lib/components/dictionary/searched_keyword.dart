import 'package:booqs_mobile/components/shared/text_with_dict_link.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:flutter/material.dart';

// 日本語などに対して分書できるようにstatefulにしておく
class DictionarySearchedKeyword extends StatefulWidget {
  const DictionarySearchedKeyword(
      {super.key, required this.keyword, required this.dictionary});
  final String keyword;
  final Dictionary dictionary;

  @override
  State<DictionarySearchedKeyword> createState() =>
      _DictionarySearchedKeywordState();
}

class _DictionarySearchedKeywordState extends State<DictionarySearchedKeyword> {
  late String _keyword;

  @override
  void initState() {
    super.initState();
    setState(() {
      _keyword = widget.keyword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${t.dictionaries.keyword}:',
            style: const TextStyle(fontSize: 14, color: Colors.black87)),
        const SizedBox(height: 4),
        TextWithDictLink(
          text: _keyword,
          langNumber: widget.dictionary.langNumberOfEntry,
          autoLinkEnabled: true,
          crossAxisAlignment: CrossAxisAlignment.start,
          dictionaryId: widget.dictionary.id,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          fontColor: Colors.black87,
          selectable: true,
        ),
      ],
    );
  }
}
