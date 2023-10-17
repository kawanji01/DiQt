import 'package:booqs_mobile/components/dictionary_map/speech/test.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:flutter/material.dart';

class DictionarySpeechTestPage extends StatefulWidget {
  const DictionarySpeechTestPage({super.key});

  static Future push(BuildContext context, Dictionary dictionary) async {
    return Navigator.of(context).pushNamed(dictionarySpeechTestPage,
        arguments: {'dictionary': dictionary});
  }

  @override
  State<DictionarySpeechTestPage> createState() =>
      _DictionarySpeechTestPageState();
}

class _DictionarySpeechTestPageState extends State<DictionarySpeechTestPage> {
  final TextEditingController _keywordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _keywordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final Dictionary? dictionary = arguments['dictionary'] as Dictionary?;

    if (dictionary == null) {
      return const Text('dictionary is null');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('test'),
      ),
      body: DictionaryMapSpeechTest(
          keywordController: _keywordController, dictionary: dictionary),
    );
  }
}
