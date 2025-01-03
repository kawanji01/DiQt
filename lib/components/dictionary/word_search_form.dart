import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/pages/dictionary/word_search_results.dart';
import 'package:booqs_mobile/utils/word_typeahead.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class DictionaryWordSearchForm extends StatefulWidget {
  const DictionaryWordSearchForm({super.key, required this.dictionary});
  final Dictionary dictionary;

  @override
  State<DictionaryWordSearchForm> createState() =>
      _DictionaryWordSearchFormState();
}

class _DictionaryWordSearchFormState extends State<DictionaryWordSearchForm> {
  final _formKey = GlobalKey<FormState>();
  final _wordSearchController = TextEditingController();

  @override
  void dispose() {
    _wordSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Dictionary dictionary = widget.dictionary;
    final int dictionaryId = dictionary.id;

    void search() {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      final String keyword = _wordSearchController.text;
      DictionaryWordSearchResultsPage.push(context, dictionaryId, keyword);
    }

    final String language = dictionary.languageOfEntry();
    final String label = t.dictionaryMaps.enter(language: language);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TypeAheadField<Word>(
            controller: _wordSearchController,
            builder: (context, controller, focusNode) {
              return TextFormField(
                controller: controller,
                focusNode: focusNode,
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
                      _wordSearchController.clear();
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
              return WordTypeahead.getSuggestions(pattern, dictionaryId);
            },
            itemBuilder: (context, word) {
              // 候補をタップしたときに検索画面に遷移する。参考： https://stackoverflow.com/questions/68375774/use-the-typeaheadformfield-inside-a-form-flutter
              return ListTile(
                title: Text(word.entry),
                onTap: () {
                  _wordSearchController.text = word.entry;
                  search();
                },
              );
            },
            // 検索結果がない場合は何も表示しない ref: https://pub.dev/packages/flutter_typeahead#customizations
            hideOnEmpty: true,
            hideOnLoading: true,
            hideOnError: true,
            onSelected: (suggestion) {
              _wordSearchController.text = "$suggestion";
            },
            transitionBuilder: (context, animation, child) {
              return FadeTransition(
                opacity: CurvedAnimation(
                    parent: animation, curve: Curves.fastOutSlowIn),
                child: child,
              );
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 40),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: search,
              icon: const Icon(Icons.search, color: Colors.white),
              label: Text(
                t.shared.search,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );

    /* return Form(
      key: _formKey,
      child: Column(
        children: [
          TypeAheadFormField(
            textFieldConfiguration: TextFieldConfiguration(
                controller: _wordSearchController,
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
                      _wordSearchController.clear();
                    },
                  ),
                )),
            suggestionsCallback: (pattern) {
              return WordTypeahead.getSuggestions(pattern, dictionaryId);
            },
            itemBuilder: (context, String suggestion) {
              // 候補をタップしたときに検索画面に遷移する。参考： https://stackoverflow.com/questions/68375774/use-the-typeaheadformfield-inside-a-form-flutter
              return ListTile(
                title: Text(suggestion),
                onTap: () {
                  _wordSearchController.text = suggestion;
                  search();
                },
              );
            },
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            onSuggestionSelected: (suggestion) {
              _wordSearchController.text = "$suggestion";
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
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ); */
  }
}
