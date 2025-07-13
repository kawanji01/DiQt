import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/components/word/item/label.dart';
import 'package:booqs_mobile/components/word/item/pos_tag_screen.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/pos_tag.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';

class WordItemPosTag extends StatelessWidget {
  const WordItemPosTag({super.key, required this.word});
  final Word word;

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
    final PosTag? posTag = word.posTag;

    if (posTag == null) {
      final String? pos = word.pos;
      if (pos == null || pos == '') {
        return Container();
      }
      return WordItemLabel(
        text: pos,
      );
    }
    
    // 表示名を多言語化対応で取得
    String displayName = posTag.name;
    if (posTag.universalName != null && posTag.universalName!.isNotEmpty) {
      try {
        displayName = _getPosTagTranslation(posTag.universalName!);
      } catch (e) {
        // 翻訳が見つからない場合は元のnameを使用
        displayName = posTag.name;
      }
    }
    
    //
    if (posTag.explanation == null || posTag.explanation == '') {
      return WordItemLabel(
        text: displayName,
      );
    }

    return InkWell(
      child: SharedItemLabel(text: displayName),
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0)),
          ),
          builder: (context) => WordItemPosTagScreen(posTag: posTag),
        );
      },
    );
  }
}
