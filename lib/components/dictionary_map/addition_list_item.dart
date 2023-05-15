import 'package:booqs_mobile/data/provider/dictionary_map.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryMapAdditionListItem extends ConsumerStatefulWidget {
  const DictionaryMapAdditionListItem({super.key, required this.dictionary});
  final Dictionary dictionary;

  @override
  DictionaryMapAdditionListItemState createState() =>
      DictionaryMapAdditionListItemState();
}

class DictionaryMapAdditionListItemState
    extends ConsumerState<DictionaryMapAdditionListItem> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
            width: 1,
          ),
        ),
      ),
      child: CheckboxListTile(
        title: Text(widget.dictionary.typeName()),
        checkColor: Colors.white,
        value: _isChecked,
        onChanged: (bool? checkedValue) {
          if (checkedValue == null) return;
          if (checkedValue) {
            ref
                .read(additionDictionaryIdsProvider.notifier)
                .state
                .add(widget.dictionary.id);
          } else {
            ref
                .read(additionDictionaryIdsProvider.notifier)
                .state
                .remove(widget.dictionary.id);
          }
          setState(() {
            _isChecked = checkedValue;
          });
        },
      ),
    );
  }
}
