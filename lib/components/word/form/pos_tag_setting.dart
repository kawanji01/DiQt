import 'package:booqs_mobile/models/pos_tag.dart';
import 'package:flutter/material.dart';

class WordFormPosTagSetting extends StatefulWidget {
  const WordFormPosTagSetting(
      {Key? key, required this.posTagIdController, required this.posTags})
      : super(key: key);
  final TextEditingController posTagIdController;
  final List<PosTag>? posTags;

  @override
  State<WordFormPosTagSetting> createState() => _WordFormPosTagSettingState();
}

class _WordFormPosTagSettingState extends State<WordFormPosTagSetting> {
  //
  Future change(String? newValue) async {
    setState(() {
      widget.posTagIdController.text = '$newValue';
    });
  }

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

    const undefinePosTag = DropdownMenuItem<String>(
      value: 'null',
      child: Text('未定義',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.black87)),
    );
    dropDownItems.insert(0, undefinePosTag);

    return Container(
      height: 48,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 15.0, right: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black54)),
      child: DropdownButton<String>(
        value: dropDownValue,
        iconSize: 24,
        elevation: 16,
        onChanged: (String? newValue) {
          change(newValue);
        },
        items: dropDownItems,
      ),
    );
  }
}
