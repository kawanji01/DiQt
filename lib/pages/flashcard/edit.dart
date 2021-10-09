import 'dart:convert';

import 'package:booqs_mobile/models/flashcard.dart';
import 'package:booqs_mobile/models/flashcard_card.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/flashcard/flashcard_card_form.dart';
import 'package:booqs_mobile/widgets/flashcard/flashcard_card_list.dart';
import 'package:booqs_mobile/widgets/flashcard/flashcard_edit_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditFlashcardPage extends StatefulWidget {
  const EditFlashcardPage({Key? key}) : super(key: key);

  static Future push(BuildContext context, Flashcard flashcard) async {
    return Navigator.of(context)
        .pushNamed(flashcardEditPage, arguments: flashcard);
  }

  @override
  _EditFlashcardPageState createState() => _EditFlashcardPageState();
}

class _EditFlashcardPageState extends State<EditFlashcardPage> {
  Flashcard? _flashcard;
  List<FlashcardCard> _flashcardCards = [];

  @override
  void initState() {
    super.initState();
    // initialize
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // パラメーターを受け取る。型をFlashcardにキャスト。
      final flashcard = ModalRoute.of(context)!.settings.arguments as Flashcard;

      setState(() {
        _flashcard = flashcard;
      });

      _loadFlashcardCards(_flashcard);
    });
  }

  // async load cards API
  Future _loadFlashcardCards(flashcard) async {
    var url = Uri.parse(
        'http://localhost:3000/ja/api/v1/mobile/dictionaries/${flashcard.id}');
    var res =
        await http.get(url, headers: {"Content-Type": "application/json"});
    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    Map<String, dynamic> resMap = json.decode(res.body);
    var data = resMap['data'];
    // Convert map to list. ref: https://qiita.com/7_asupara/items/01c29c006556e89f5b17
    data.forEach((e) => _flashcardCards.add(FlashcardCard.fromJson(e)));
    //final flashcards = _flashcards;
    setState(() {
      _flashcardCards;
    });
  }

  Future _showEditDialog() async {
    final newName = await showDialog<String>(
        context: context,
        builder: (context) {
          return FlashcardEditDialog(flashcard: _flashcard!);
        });
    if (newName == null) {
      return;
    }

    setState(() {
      _flashcard!.title = newName;
    });
    //await FlashcardRepository.update(_flashcard);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_flashcard?.title ?? ''), actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: _showEditDialog,
        )
      ]),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            FlashcardCardForm(),
            Expanded(
              child: FlashcardCardList(flashcardCards: _flashcardCards),
            ),
          ],
        ),
      ),
    );
  }
}
