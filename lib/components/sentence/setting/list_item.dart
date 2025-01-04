import 'package:booqs_mobile/components/sentence/item/content.dart';
import 'package:booqs_mobile/components/sentence/item/edit_button.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/components/button/small_green_button.dart';
import 'package:flutter/material.dart';

class SentenceSettingListItem extends StatelessWidget {
  const SentenceSettingListItem({super.key, required this.sentence});
  final Sentence sentence;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SentenceItemContent(sentence: sentence),
            const SizedBox(height: 8),
            InkWell(
                onTap: () {
                  return Navigator.of(context).pop({'set': sentence});
                },
                child: SmallGreenButton(
                    label: t.shared.set_up, icon: Icons.check)),
            const SizedBox(height: 8),
            SentenceItemEditButton(
              sentence: sentence,
            ),
          ]),
    );
  }
}
