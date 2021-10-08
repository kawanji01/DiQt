import 'dart:convert';
import 'package:booqs_mobile/models/flashcard.dart';
import 'package:booqs_mobile/pages/flashcard/edit.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Flashcard> _flashcards = [];

  // initialize
  @override
  void initState() {
    super.initState();

    _loadFlashcards();
  }

// async create list
  Future _loadFlashcards() async {
    var url = Uri.parse('http://localhost:3000/ja/api/v1/mobile/dictionaries');
    var res =
        await http.get(url, headers: {"Content-Type": "application/json"});
    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    Map<String, dynamic> resMap = json.decode(res.body);
    var data = resMap['data'];
    debugPrint('--- ${Flashcard.fromJson(data[0])}');
    // Convert map to list. ref: https://qiita.com/7_asupara/items/01c29c006556e89f5b17
    data.forEach((e) => _flashcards.add(Flashcard.fromJson(e)));
    //final flashcards = _flashcards;
    setState(() {
      _flashcards;
    });
  }

  Future _goToCreatePage() async {
    await Navigator.of(context).pushNamed(flashcardCreatePage);
  }

  Future _goToEditPage(Flashcard flashcard) async {
    await EditFlashcardPage.push(context, flashcard);

    //await _loadFlashcards();
  }

  Widget _buildListRow(BuildContext context, int index) {
    final flashcard = _flashcards[index];
    return ListTile(
      title: Text(flashcard.title),
      onTap: () => _goToEditPage(flashcard),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('単語帳'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: _buildListRow,
              separatorBuilder: (context, index) => const Divider(),
              itemCount: _flashcards.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToCreatePage,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
