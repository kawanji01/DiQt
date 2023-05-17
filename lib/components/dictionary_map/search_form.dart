import 'package:booqs_mobile/components/dictionary/name.dart';
import 'package:booqs_mobile/data/provider/dictionary_map.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/pages/dictionary/word_search_results.dart';
import 'package:booqs_mobile/utils/word_typeahead.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class DictionaryMapSearchForm extends ConsumerStatefulWidget {
  const DictionaryMapSearchForm({Key? key}) : super(key: key);

  @override
  DictionaryWordSearchFormState createState() =>
      DictionaryWordSearchFormState();
}

class DictionaryWordSearchFormState
    extends ConsumerState<DictionaryMapSearchForm> {
  final _formKey = GlobalKey<FormState>();
  final _keywordController = TextEditingController();

  @override
  void dispose() {
    _keywordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Dictionary? dictionary = ref.watch(selectedDictionaryProvider);
    final int? dictionaryId = dictionary?.id;
    final String label;
    if (dictionary == null) {
      label = t.dictionaryMaps.please_select;
    } else {
      final String language = dictionary.languageOfEntry();
      label = t.dictionaryMaps.enter(language: language);
    }

    void search() {
      if (dictionary == null) return;
      if (!_formKey.currentState!.validate()) {
        return;
      }
      final String keyword = _keywordController.text;
      DictionaryWordSearchResultsPage.push(context, dictionary.id, keyword);
    }

    Widget dictionaryName() {
      if (dictionary == null) {
        return Text(t.dictionaryMaps.not_selected,
            style: const TextStyle(fontSize: 12, color: Colors.red));
      } else {
        return DictionaryName(dictionary: dictionary);
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dictionaryName(),
          const SizedBox(
            height: 16,
          ),
          TypeAheadFormField(
            textFieldConfiguration: TextFieldConfiguration(
                controller: _keywordController,
                // 改行を許さず、文字数に応じて自動で改行表示する。
                keyboardType: TextInputType.text,
                maxLines: null,
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
                      _keywordController.clear();
                    },
                  ),
                )),
            suggestionsCallback: (pattern) {
              if (dictionaryId == null) return [];
              return WordTypeahead.getSuggestions(pattern, dictionaryId);
            },
            itemBuilder: (context, dynamic suggestion) {
              final String suggestedEntry = suggestion as String;
              // 候補をタップしたときに検索画面に遷移する。参考： https://stackoverflow.com/questions/68375774/use-the-typeaheadformfield-inside-a-form-flutter
              return ListTile(
                title: Text(suggestedEntry),
                onTap: () {
                  _keywordController.text = suggestedEntry;
                  search();
                },
              );
            },
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            onSuggestionSelected: (suggestion) {
              _keywordController.text = "$suggestion";
            },
            validator: (value) {
              if (value!.isEmpty) {
                return t.errors.cant_be_blank;
              }
              return null;
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 40),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity,
                    48), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
              ),
              onPressed: search,
              icon: const Icon(Icons.search, color: Colors.white),
              label: Text(
                t.shared.search,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
