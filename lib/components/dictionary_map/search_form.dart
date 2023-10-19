import 'package:booqs_mobile/components/dictionary/name.dart';
import 'package:booqs_mobile/components/dictionary_map/search_button.dart';
import 'package:booqs_mobile/components/dictionary_map/search_field.dart';
import 'package:booqs_mobile/components/dictionary_map/search_options_button.dart';
import 'package:booqs_mobile/data/provider/dictionary_map.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/pages/dictionary/word_search_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      FocusScope.of(context).unfocus();
      final String keyword = _keywordController.text;
      DictionaryWordSearchResultsPage.push(context, dictionary.id, keyword);
    }

    Widget dictionaryName() {
      if (dictionary == null) {
        return Text(t.dictionaryMaps.not_selected,
            style: const TextStyle(fontSize: 12, color: Colors.black54));
      } else {
        return DictionaryName(
          dictionary: dictionary,
          linked: true,
        );
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            dictionaryName(),
            DictionaryMapSearchOptionsButton(
                keywordController: _keywordController, dictionary: dictionary)
          ]),
          //const SizedBox(
          //  height: 16,
          //),
          DictionaryMapSearchField(
              keywordController: _keywordController,
              label: label,
              dictionaryId: dictionaryId,
              search: search),

          DictionaryMapSearchButton(
            onPressed: search,
          ),
        ],
      ),
    );
  }
}
