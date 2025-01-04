import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/pos_tag.dart';
import 'package:flutter/material.dart';

class WordFormPosTag extends StatefulWidget {
  const WordFormPosTag(
      {super.key,
      required this.posTagIdController,
      required this.posTags,
      required this.enabled});
  final TextEditingController posTagIdController;
  final List<PosTag>? posTags;
  final bool enabled;

  @override
  State<WordFormPosTag> createState() => WordFormPosTagState();
}

class WordFormPosTagState extends State<WordFormPosTag> {
  @override
  Widget build(BuildContext context) {
    List<PosTag?>? posTags = widget.posTags;
    if (posTags == null) {
      return Container();
    }
    if (posTags.isEmpty) {
      return Container();
    }
    String dropDownValue = widget.posTagIdController.text;
    // エラー対策： もしposTagIdsにdropDownValueが存在しない場合には、dropDownValueを'null'に書き換える。
    final List<String> posTagIds = posTags.map<String>((PosTag? posTag) {
      return '${posTag?.id}';
    }).toList();
    if (posTagIds.contains(dropDownValue) == false) {
      dropDownValue = 'null';
    }

    // dropDownItemsの生成
    List<DropdownMenuItem<String>> dropDownItems =
        posTags.map<DropdownMenuItem<String>>((PosTag? posTag) {
      return DropdownMenuItem<String>(
        value: '${posTag?.id}',
        child: Text('${posTag?.name}',
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black87)),
      );
    }).toList();

    final undefinePosTag = DropdownMenuItem<String>(
      value: 'null',
      child: Text(t.shared.undefined,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.black87)),
    );
    dropDownItems.insert(0, undefinePosTag);

    //

    if (widget.enabled) {
      return DropdownButtonFormField<String>(
        decoration:
            InputDecoration(filled: false, labelText: t.words.pos_tag_id),
        value: dropDownValue,
        iconSize: 24,
        elevation: 16,
        onChanged: (String? newValue) {
          setState(() {
            widget.posTagIdController.text = '$newValue';
          });
        },
        items: dropDownItems,
      );
    } else {
      return AbsorbPointer(
        child: DropdownButtonFormField<String>(
          icon: const SizedBox.shrink(),
          decoration: InputDecoration(
              filled: !widget.enabled, labelText: t.sentences.pos),
          value: dropDownValue,
          iconSize: 24,
          elevation: 16,
          onChanged: (String? newValue) {},
          items: dropDownItems,
        ),
      );
    }
  }
}
