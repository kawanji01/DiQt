import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/pages/dictionary/show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryName extends ConsumerWidget {
  const DictionaryName({Key? key, required this.dictionary}) : super(key: key);
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final button = InkWell(
      onTap: () {
        ref.read(dictionaryProvider.notifier).state = dictionary;
        DictionaryShowPage.push(context, dictionary.id);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: Colors.green, width: 1),
        ),
        child: RichText(
          text: TextSpan(
            style: const TextStyle(
                fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold),
            children: [
              const WidgetSpan(
                child: Icon(
                  Icons.search,
                  size: 16,
                  color: Colors.green,
                ),
              ),
              TextSpan(
                text: dictionary.typeName(),
              ),
            ],
          ),
        ),
      ),
    );

    //return button;
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [button]);
  }
}
