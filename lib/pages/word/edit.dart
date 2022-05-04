import 'package:booqs_mobile/data/provider/word.dart';
import 'package:booqs_mobile/data/remote/words.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/pages/word/show.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/word/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordEditPage extends ConsumerStatefulWidget {
  const WordEditPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(wordEditPage);
  }

  @override
  _WordEditPageState createState() => _WordEditPageState();
}

class _WordEditPageState extends ConsumerState<WordEditPage> {
  Word? _word;
  int? _dictionaryId;
  // validatorを利用するために必要なkey
  final _formKey = GlobalKey<FormState>();
  final _entryController = TextEditingController();
  final _meaningController = TextEditingController();
  final _explanationController = TextEditingController();
  final _sentenceIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _word = ref.watch(wordProvider);
      _entryController.text = _word!.entry;
      _meaningController.text = _word!.meaning;
      _explanationController.text = _word!.explanation ?? '';
      _sentenceIdController.text = _word!.sentenceId.toString();
      _dictionaryId = _word!.dictionaryId;
      setState(() {
        _word;
      });
    });
  }

  @override
  // widgetの破棄時にコントローラも破棄する。Controllerを使うなら必ず必要。
  // 参考： https://api.flutter.dev/flutter/widgets/TextEditingController-class.html
  void dispose() {
    _entryController.dispose();
    _meaningController.dispose();
    _explanationController.dispose();
    _sentenceIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_word == null) return Container();

    Future _goToWordPage(word) async {
      ref.read(wordProvider.notifier).state = word;
      ref.read(wordIdProvider.notifier).state = word!.id;
      await WordShowPage.pushReplacement(context);
    }

    Future _save(word) async {
      // 各Fieldのvalidatorを呼び出す
      if (!_formKey.currentState!.validate()) return;

      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');

      /* const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');

      // リクエスト
      var url = Uri.parse(
          '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/words/${word.id}');

      Response response = await patch(url, body: {
        'token': token,
        'entry': _entryController.text,
        'meaning': _meaningController.text,
        'explanation': _explanationController.text,
        'sentence_id': _sentenceIdController.text,
      }); */
      Map<String, dynamic> params = word.toJson();
      params['entry'] = _entryController.text;
      params['meaning'] = _meaningController.text;
      params['explanation'] = _explanationController.text;
      params['sentence_id'] = _sentenceIdController.text;
      final Map? resMap = await RemoteWords.update(params);

      if (resMap == null) {
        EasyLoading.dismiss();
        const snackBar = SnackBar(content: Text('辞書を更新できませんでした。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        word = Word.fromJson(resMap['word']);
        final snackBar = SnackBar(content: Text('${resMap['message']}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        _goToWordPage(word);
      }
      EasyLoading.dismiss();

      /* if (response.statusCode == 200) {
        // 画面全体のローディングを消す。
        EasyLoading.dismiss();
        Map<String, dynamic> resMap = json.decode(response.body);
        word = Word.fromJson(resMap['data']);
        final snackBar = SnackBar(content: Text('${resMap['message']}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        _goToWordPage(word);
      } else {
        EasyLoading.dismiss();
        const snackBar = SnackBar(content: Text('辞書を更新できませんでした。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } */
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
            _save(_word),
          },
          icon: const Icon(Icons.update, color: Colors.white),
          label: const Text(
            '更新する',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${_word!.entry}の編集'),
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
