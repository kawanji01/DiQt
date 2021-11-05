import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';

class WordEditForm extends StatefulWidget {
  const WordEditForm({Key? key, required this.word}) : super(key: key);
  final Word word;
  @override
  _WordEditFormState createState() => _WordEditFormState();
}

class _WordEditFormState extends State<WordEditForm> {
  final _formKey = GlobalKey<FormState>();
  final _entryController = TextEditingController();
  final _meaningController = TextEditingController();
  final _explanationController = TextEditingController();

  Word? _word;
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final word = ModalRoute.of(context)!.settings.arguments as Word;
      setState(() {
        _word = word;
      });
      //_loadWord(word);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
