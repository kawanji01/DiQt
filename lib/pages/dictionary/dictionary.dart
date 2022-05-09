import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/dictionary/introduction.dart';
import 'package:booqs_mobile/widgets/dictionary/quiz_requests_button.dart';
import 'package:booqs_mobile/widgets/dictionary/sentence_requests_button.dart';
import 'package:booqs_mobile/widgets/dictionary/word_requests_button.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryPage extends ConsumerStatefulWidget {
  const DictionaryPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(dictionaryShowPage);
  }

  @override
  _DictionaryPageState createState() => _DictionaryPageState();
}

class _DictionaryPageState extends ConsumerState<DictionaryPage> {
  @override
  void initState() {
    super.initState();
    ref.refresh(asyncDictionaryProvider);
  }

  @override
  Widget build(BuildContext context) {
    final Dictionary? _dictionary = ref.watch(dictionaryProvider);
    final future = ref.watch(asyncDictionaryProvider);

    Widget _page(Dictionary? dictionary) {
      if (dictionary == null) return Container();

      return SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 24),
              DictionaryIntroduction(dictionary: dictionary),
              DictionaryWordRequestsButton(dictionary: dictionary),
              const SizedBox(height: 24),
              DictionarySentenceRequestsButton(dictionary: dictionary),
              const SizedBox(height: 24),
              DictionaryQuizRequestsButton(dictionary: dictionary),
              const SizedBox(height: 48),
            ],
          ),
        ),
      );
    }

    final String title = _dictionary == null ? '' : _dictionary.title;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: future.when(
        loading: () => _page(_dictionary),
        error: (err, stack) => Text('Error: $err'),
        data: (dictionary) => _page(dictionary),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
