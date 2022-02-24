import 'dart:convert';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/pages/home.dart';
import 'package:booqs_mobile/pages/word/show.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/word/word_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

class WordNewPage extends StatefulWidget {
  const WordNewPage({Key? key}) : super(key: key);

  static Future push(
      BuildContext context, Dictionary dictionary, String keyword) async {
    return Navigator.of(context).pushNamed(wordNewPage,
        arguments: {'dictionary': dictionary, 'keyword': keyword});
  }

  @override
  _WordNewPageState createState() => _WordNewPageState();
}

class _WordNewPageState extends State<WordNewPage> {
  Dictionary? _dictionary;
  int? _dictionaryId;
  String? _keyword;
  // validatorを利用するために必要なkey
  final _formKey = GlobalKey<FormState>();
  final _entryController = TextEditingController();
  final _meaningController = TextEditingController();
  final _explanationController = TextEditingController();
  final _sentenceIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 複数の引数を受け取る。参考： https://stackoverflow.com/questions/53304340/navigator-pass-arguments-with-pushnamed
    // exeception回避
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      setState(() {
        _dictionary = arguments['dictionary'] as Dictionary;
        _dictionaryId = _dictionary?.id;
        _keyword = arguments['keyword'].toString();
        _entryController.text = _keyword!;
      });
    });
  }

  // widgetの破棄時にコントローラも破棄する。Controllerを使うなら必ず必要。
  // 参考： https://api.flutter.dev/flutter/widgets/TextEditingController-class.html
  @override
  void dispose() {
    _entryController.dispose();
    _meaningController.dispose();
    _explanationController.dispose();
    _sentenceIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future _goToWordPage(word) async {
      await WordShowPage.pushReplacement(context, word.id);
    }

    Future _create() async {
      // 各Fieldのvalidatorを呼び出す
      if (!_formKey.currentState!.validate()) return;

      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');

      // リクエスト
      var url = Uri.parse(
          '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/words');

      Response response = await post(url, body: {
        'token': token,
        'entry': _entryController.text,
        'meaning': _meaningController.text,
        'explanation': _explanationController.text,
        'sentence_id': _sentenceIdController.text,
        'dictionary_id': '$_dictionaryId',
      });

      if (response.statusCode == 200) {
        // 画面全体のローディングを消す。
        EasyLoading.dismiss();
        Map<String, dynamic> resMap = json.decode(response.body);
        Word word = Word.fromJson(resMap['data']);
        final snackBar = SnackBar(content: Text('${resMap['message']}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // 項目の追加に審査が必要ならホームに遷移
        if (word.id == null) return MyHomePage.push(context);
        // 項目が作成されていれば項目ページに遷移。
        _goToWordPage(word);
      } else {
        EasyLoading.dismiss();
        const snackBar = SnackBar(content: Text('辞書を更新できませんでした。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    // 更新ボタン
    Widget _submitButton() {
      return SizedBox(
        height: 48,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity,
                40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
          ),
          onPressed: () => {
            _create(),
          },
          icon: const Icon(Icons.update, color: Colors.white),
          label: const Text(
            '作成する',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${_entryController.text}の作成'),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(20),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      WordForm(
                        entryController: _entryController,
                        meaningController: _meaningController,
                        explanationController: _explanationController,
                        sentenceIdController: _sentenceIdController,
                        dictionaryId: _dictionaryId,
                      ),
                      const SizedBox(height: 40),
                      _submitButton(),
                      const SizedBox(height: 40),
                    ]))),
      ),
      bottomNavigationBar: const BottomNavbar(selectedIndex: 0),
    );
  }
}
