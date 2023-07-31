import 'package:booqs_mobile/components/dictionary/show_screen.dart';
import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryShowPage extends ConsumerStatefulWidget {
  const DictionaryShowPage({Key? key}) : super(key: key);

  static Future push(BuildContext context, int dictionaryId) async {
    return Navigator.of(context).pushNamed(dictionaryShowPage,
        arguments: {'dictionaryId': dictionaryId});
  }

  static Future pushReplacement(BuildContext context, int dictionaryId) async {
    return Navigator.of(context)
        .pushReplacementNamed(dictionaryShowPage, arguments: {
      'dictionaryId': dictionaryId,
    });
  }

  @override
  DictionaryShowPageState createState() => DictionaryShowPageState();
}

class DictionaryShowPageState extends ConsumerState<DictionaryShowPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      final int dictionaryId = arguments['dictionaryId'];
      ref.invalidate(asyncDictionaryFamily(dictionaryId));
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final int dictionaryId = arguments['dictionaryId'];
    final Dictionary? dictionary = ref.watch(dictionaryProvider);
    final future = ref.watch(asyncDictionaryFamily(dictionaryId));

    Widget page(Dictionary? dictionary) {
      if (dictionary == null) return const LoadingSpinner();
      return DictionaryShowScreen(dictionary: dictionary);
    }

    return Scaffold(
      appBar: AppBar(
        title: future.when(
          data: (date) => Text('${date?.typeName()}'),
          error: (err, stack) => Text('Error: $err'),
          loading: () => Text('${dictionary?.typeName()}'),
        ),
      ),
      body: future.when(
        data: (date) => page(date),
        error: (err, stack) => Text('Error: $err'),
        loading: () => page(dictionary),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
