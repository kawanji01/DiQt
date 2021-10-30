import 'dart:convert';
import 'package:booqs_mobile/models/flashcard.dart';
import 'package:booqs_mobile/pages/dictionary/search_en_ja.dart';
import 'package:booqs_mobile/pages/flashcard/edit.dart';
import 'package:booqs_mobile/pages/notification/push_test.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/dictionary/search_form.dart';
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
  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(indexPage);
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Flashcard> _flashcards = [];

  // form に必要な素材
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  void _search() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _goToSearchEnJaPage(_nameController.text);
  }

  // floatingButtonを押した時にフォームにフォーカスさせるための処理 / https://flutter.dev/docs/cookbook/forms/focus
  // Define the focus node. To manage the lifecycle, create the FocusNode in
  // the initState method, and clean it up in the dispose method.（dosposeは定義していない）
  late FocusNode myFocusNode;

  // initialize
  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    _loadDictionaries();
  }

// async create list
  Future _loadDictionaries() async {
    var url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/api/v1/mobile/dictionaries');
    var res =
        await http.get(url, headers: {"Content-Type": "application/json"});
    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    Map<String, dynamic> resMap = json.decode(res.body);
    var data = resMap['data'];
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
  }

  Future _goToSearchEnJaPage(keyword) async {
    //await Navigator.of(context).pushNamed(searchEnJaPage);
    await SearchEnJaPage.push(context, keyword);
  }

  Widget _buildListRow(BuildContext context, int index) {
    final flashcard = _flashcards[index];

    return ListTile(
      title: Text(flashcard.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        //children: [
        //  IconButton(
        //    icon: const Icon(Icons.arrow_forward_ios_rounded),
        //    onPressed: () => _goToEditPage(flashcard),
        //  ),
        //],
      ),
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
        title: const Text('辞書'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SearchForm(
                    nameController: _nameController,
                    focusNode: myFocusNode,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 40),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity,
                            40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
                      ),
                      onPressed: _search,
                      child: const Text(
                        '辞書を引く',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
      ),
      bottomNavigationBar: const BottomNavbar(selectedIndex: 0),
      floatingActionButton: FloatingActionButton(
        onPressed: () => myFocusNode.requestFocus(),
        tooltip: 'Increment',
        child: const Icon(Icons.search),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
