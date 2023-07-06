import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/markdown/markdown_with_dict_link.dart';
import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryGuidelinePage extends ConsumerWidget {
  const DictionaryGuidelinePage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(dictionaryGuidelinePage);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Dictionary? dictionary = ref.watch(dictionaryProvider);

    Widget guideline() {
      if (dictionary == null) {
        const Text('Dictionary does not exists.');
      }
      final String guideline = dictionary?.guideline ?? '';

      return MarkdownWithDictLink(
          text: guideline,
          dictionaryId: dictionary!.id,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          fontColor: Colors.black87,
          selectable: true);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(t.dictionaries.guideline),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: guideline(),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
