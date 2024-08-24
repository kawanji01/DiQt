import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/pages/dictionary/sentence_search_results.dart';
import 'package:flutter/material.dart';

class DictionarySentenceSearchForm extends StatefulWidget {
  const DictionarySentenceSearchForm({Key? key, required this.dictionary})
      : super(key: key);
  final Dictionary dictionary;

  @override
  State<DictionarySentenceSearchForm> createState() =>
      _DictionarySentenceSearchFormState();
}

class _DictionarySentenceSearchFormState
    extends State<DictionarySentenceSearchForm> {
  final _formKey = GlobalKey<FormState>();
  final _sentenceSearchController = TextEditingController();

  @override
  void dispose() {
    _sentenceSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Dictionary dictionary = widget.dictionary;
    final int dictionaryId = dictionary.id;

    final String language = dictionary.languageOfEntry();
    final String label = t.dictionaryMaps.enter(language: language);

    void search() {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      final String keyword = _sentenceSearchController.text;
      DictionarySentenceSearchResultsPage.push(context, dictionaryId, keyword);
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _sentenceSearchController,
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
                  _sentenceSearchController.clear();
                },
              ),
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
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
    );
  }
}
