import 'package:booqs_mobile/data/provider/word.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/word/show_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';

class WordShowPage extends ConsumerStatefulWidget {
  const WordShowPage({Key? key}) : super(key: key);

  // メモ：遷移の処理は、いちいち描き直す必要はないので、createStateの上に置く。
  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(wordShowPage);
  }

  // 戻らせない画面遷移
  static Future pushReplacement(BuildContext context) async {
    return Navigator.of(context).pushReplacementNamed(wordShowPage);
  }

  @override
  _WordShowPageState createState() => _WordShowPageState();
}

class _WordShowPageState extends ConsumerState<WordShowPage> {
  Word? _word;
  String _entry = '';

  @override
  void initState() {
    super.initState();
    ref.refresh(asyncWordProvider);
  }

  @override
  Widget build(BuildContext context) {
    _word = ref.watch(wordProvider);
    if (_word != null) _entry = _word!.entry;

    final future = ref.watch(asyncWordProvider);

    Widget _screen(word) {
      if (word == null) return const LoadingSpinner();
      return WordShowScreen(word: word);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_entry),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: future.when(
              data: (word) => _screen(word),
              error: (err, stack) => Text('Error: $err'),
              loading: () => _screen(_word)),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
