import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/pages/dictionary/show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordRequestItemDictionary extends ConsumerWidget {
  const WordRequestItemDictionary({super.key, required this.dictionary});
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(dictionaryProvider.notifier).state = dictionary;
        DictionaryShowPage.push(context, dictionary.id);
      },
      child: Container(
          margin: const EdgeInsets.only(bottom: 4),
          child: Text(dictionary.typeName(),
              style: const TextStyle(fontSize: 14, color: Colors.black54))),
    );
  }
}
