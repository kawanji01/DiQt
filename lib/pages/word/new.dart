import 'package:booqs_mobile/data/provider/word.dart';
import 'package:booqs_mobile/data/remote/words.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/pages/home.dart';
import 'package:booqs_mobile/pages/word/show.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/word/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordNewPage extends ConsumerStatefulWidget {
  const WordNewPage({Key? key}) : super(key: key);

  static Future push(
      BuildContext context, Dictionary dictionary, String keyword) async {
    return Navigator.of(context).pushNamed(wordNewPage,
        arguments: {'dictionary': dictionary, 'keyword': keyword});
  }

  @override
  _WordNewPageState createState() => _WordNewPageState();
}

class _WordNewPageState extends ConsumerState<WordNewPage> {
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
      // 項目の追加に審査が必要ならホームに遷移
      if (word.id == null) return MyHomePage.push(context);
      // 項目が作成されていれば項目ページに遷移。
      ref.read(wordProvider.notifier).state = word;
      await WordShowPage.pushReplacement(context);
    }

    Future _create() async {
      // 各Fieldのvalidatorを呼び出す
      if (!_formKey.currentState!.validate()) return;
      final Word word = Word(
        dictionaryId: 1,
        entry: _entryController.text,
        meaning: _meaningController.text,
        langNumberOfEntry: 22,
        langNumberOfMeaning: 44,
        sentenceId: _sentenceIdController.text == ''
            ? null
            : int.parse(_sentenceIdController.text),
      );
      final Map<String, dynamic> params = word.toJson();

      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      final Map? resMap = await RemoteWords.create(params);
      if (resMap == null) {
        EasyLoading.dismiss();
        const snackBar = SnackBar(content: Text('辞書を更新できませんでした。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final Word word = Word.fromJson(resMap['data']);
        final snackBar = SnackBar(content: Text('${resMap['message']}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        _goToWordPage(word);
      }
      // 画面全体のローディングを消す。
      EasyLoading.dismiss();
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
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
