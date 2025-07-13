import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/pos_tag.dart';
import 'package:flutter/material.dart';

class WordFormPosTag extends StatefulWidget {
  const WordFormPosTag(
      {super.key,
      required this.posTagIdController,
      required this.posTags,
      required this.enabled,
      required this.posTagRequired});
  final TextEditingController posTagIdController;
  final List<PosTag>? posTags;
  final bool enabled;
  final bool posTagRequired;

  @override
  State<WordFormPosTag> createState() => WordFormPosTagState();
}

class WordFormPosTagState extends State<WordFormPosTag> {
  // universal_nameからposTags.yamlの翻訳を取得するヘルパーメソッド
  String _getPosTagTranslation(String universalName) {
    switch (universalName) {
      case 'abbrev':
        return t.posTags.abbrev;
      case 'adj':
        return t.posTags.adj;
      case 'adv':
        return t.posTags.adv;
      case 'affix':
        return t.posTags.affix;
      case 'article':
        return t.posTags.article;
      case 'aux':
        return t.posTags.aux;
      case 'character':
        return t.posTags.character;
      case 'circumfix':
        return t.posTags.circumfix;
      case 'circumpos':
        return t.posTags.circumpos;
      case 'classifier':
        return t.posTags.classifier;
      case 'combining_form':
        return t.posTags.combining_form;
      case 'conj':
        return t.posTags.conj;
      case 'contraction':
        return t.posTags.contraction;
      case 'counter':
        return t.posTags.counter;
      case 'det':
        return t.posTags.det;
      case 'grammar':
        return t.posTags.grammar;
      case 'infix':
        return t.posTags.infix;
      case 'interfix':
        return t.posTags.interfix;
      case 'intj':
        return t.posTags.intj;
      case 'name':
        return t.posTags.name;
      case 'noun':
        return t.posTags.noun;
      case 'num':
        return t.posTags.num;
      case 'particle':
        return t.posTags.particle;
      case 'perp':
        return t.posTags.perp;
      case 'phrase':
        return t.posTags.phrase;
      case 'postp':
        return t.posTags.postp;
      case 'prefix':
        return t.posTags.prefix;
      case 'prep':
        return t.posTags.prep;
      case 'prep_phrase':
        return t.posTags.prep_phrase;
      case 'preverb':
        return t.posTags.preverb;
      case 'pron':
        return t.posTags.pron;
      case 'proverb':
        return t.posTags.proverb;
      case 'punct':
        return t.posTags.punct;
      case 'romanization':
        return t.posTags.romanization;
      case 'root':
        return t.posTags.root;
      case 'suffix':
        return t.posTags.suffix;
      case 'syllable':
        return t.posTags.syllable;
      case 'symbol':
        return t.posTags.symbol;
      case 'verb':
        return t.posTags.verb;
      default:
        throw Exception('Unknown universal_name: $universalName');
    }
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

    // dropDownItemsの生成
    List<DropdownMenuItem<String>> dropDownItems =
        posTags.map<DropdownMenuItem<String>>((PosTag? posTag) {
      // universal_nameをキーにしてposTags.yamlから翻訳を取得
      String displayName = posTag?.name ?? '';
      if (posTag?.universalName != null && posTag!.universalName!.isNotEmpty) {
        try {
          displayName = _getPosTagTranslation(posTag.universalName!);
        } catch (e) {
          // 翻訳が見つからない場合は元のnameを使用
          displayName = posTag.name;
        }
      }
      
      return DropdownMenuItem<String>(
        value: '${posTag?.id}',
        child: Text(displayName,
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
    String? validatePosTag(String? value) {
      if (widget.posTagRequired && (value == null || value == 'null')) {
        return t.words.pos_tag_required;
      }
      return null;
    }

    if (widget.enabled) {
      return DropdownButtonFormField<String>(
        decoration:
            InputDecoration(filled: false, labelText: t.words.pos_tag_id),
        value: dropDownValue,
        iconSize: 24,
        elevation: 16,
        validator: validatePosTag,
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
          validator: validatePosTag,
          onChanged: (String? newValue) {},
          items: dropDownItems,
        ),
      );
    }
  }
}
