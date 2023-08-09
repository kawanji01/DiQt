import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class WordFormDetailedSettings extends StatelessWidget {
  const WordFormDetailedSettings({
    Key? key,
    required this.ipaController,
  }) : super(key: key);

  final TextEditingController ipaController;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        t.words.detailed_settings,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      //collapsedBackgroundColor: const Color(0xfff3f3f4),
      collapsedBackgroundColor: Colors.grey.shade200,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48),
            // IPA
            TextFormField(
              controller: ipaController,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: t.words.ipa,
                  hintText: t.shared.please_enter(name: t.words.ipa)),
            ),
            const SizedBox(height: 48),
            // 語源
            /* TextFormField(
              controller: etymologiesController,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: t.words.etymologies,
                  hintText: t.shared.please_enter(name: t.words.etymologies)),
            ), */
            const SizedBox(height: 48),
          ],
        ),
      ],
    );
  }
}
