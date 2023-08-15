import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/pages/dictionary/show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryName extends ConsumerWidget {
  const DictionaryName(
      {Key? key, required this.dictionary, required this.linked})
      : super(key: key);
  final Dictionary dictionary;
  final bool linked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (linked) {
      return InkWell(
          onTap: () {
            ref.read(dictionaryProvider.notifier).state = dictionary;
            DictionaryShowPage.push(context, dictionary.id);
          },
          child: Text(dictionary.typeName(),
              style: const TextStyle(fontSize: 12, color: Colors.black54)));
    } else {
      return Text(dictionary.typeName(),
          style: const TextStyle(fontSize: 12, color: Colors.black54));
    }
  }
}
