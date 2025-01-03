import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/word_typeahead.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class DictionaryMapSearchField extends StatelessWidget {
  const DictionaryMapSearchField(
      {super.key,
      required this.keywordController,
      required this.label,
      required this.dictionaryId,
      required this.search});
  final TextEditingController keywordController;
  final String label;
  final int? dictionaryId;
  final void Function() search;

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      builder: (context, controller, focusNode) {
        return TextFormField(
          controller: keywordController,
          // 改行を許さず、文字数に応じて自動で改行表示する。
          keyboardType: TextInputType.text,
          minLines: 1,
          maxLines: 4,
          decoration: InputDecoration(
            labelText: label,
            // design ref: https://qiita.com/OzWay_Jin/items/60c90ff297aec4ac743c
            filled: true,
            fillColor: Colors.grey.shade200,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                keywordController.clear();
              },
            ),
          ),
          // Enterキーが押された時に_submitFormを呼ぶ
          onEditingComplete: search,
          validator: (value) {
            if (value!.isEmpty) {
              return t.errors.cant_be_blank;
            }

            return null;
          },
        );
      },
      suggestionsCallback: (pattern) {
        if (dictionaryId == null) return [];
        return WordTypeahead.getSuggestions(pattern, dictionaryId!);
      },
      itemBuilder: (context, dynamic suggestion) {
        final String suggestedEntry = suggestion as String;
        // 候補をタップしたときに検索画面に遷移する。参考： https://stackoverflow.com/questions/68375774/use-the-typeaheadformfield-inside-a-form-flutter
        return ListTile(
          title: Text(suggestedEntry),
          onTap: () {
            keywordController.text = suggestedEntry;
            search();
          },
        );
      },
      // 検索結果がない場合は何も表示しない ref: https://pub.dev/packages/flutter_typeahead#customizations
      hideOnEmpty: true,
      hideOnLoading: true,
      hideOnError: true,
      //transitionBuilder: (context, suggestionsBox, controller) {
      //  return suggestionsBox;
      //},
      onSelected: (suggestion) {
        keywordController.text = "$suggestion";
      },
    );
  }
}
