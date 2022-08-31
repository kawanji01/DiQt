import 'package:booqs_mobile/data/provider/word.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/word/show_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';

class WordShowPage extends ConsumerStatefulWidget {
  const WordShowPage({Key? key}) : super(key: key);

  // メモ：遷移の処理は、いちいち描き直す必要はないので、createStateの上に置く。
  static Future push(BuildContext context, int wordId) async {
    return Navigator.of(context)
        .pushNamed(wordShowPage, arguments: {'wordId': wordId});
  }

  // 戻らせない画面遷移
  static Future pushReplacement(BuildContext context, int wordId) async {
    return Navigator.of(context)
        .pushReplacementNamed(wordShowPage, arguments: {'wordId': wordId});
  }

  @override
  _WordShowPageState createState() => _WordShowPageState();
}

class _WordShowPageState extends ConsumerState<WordShowPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      final int wordId = arguments['wordId'];
      ref.refresh(asyncWordFamily(wordId));
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final int _wordId = arguments['wordId'];
    final Word? _word = ref.watch(wordProvider);
    final future = ref.watch(asyncWordFamily(_wordId));

    Widget _screen(word) {
      if (word == null) {
        return const LoadingSpinner();
      }
      return WordShowScreen(word: word);
    }

    Widget _title() {
      return future.when(
        data: (word) => Text(word?.entry ?? ''),
        error: (err, stack) => const Text('Error'),
        loading: () => Text(_word?.entry ?? ''),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: 24,
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: future.when(
            data: (word) => _screen(word),
            error: (err, stack) => Text('Error: $err'),
            loading: () => _screen(_word),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
