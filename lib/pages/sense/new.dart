import 'package:booqs_mobile/components/sense/form.dart';
import 'package:booqs_mobile/components/sense/word_entry.dart';
import 'package:booqs_mobile/data/remote/senses.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/sense.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/pages/sense/show.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/dictionary/name.dart';
import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SenseNewPage extends ConsumerStatefulWidget {
  const SenseNewPage({Key? key}) : super(key: key);

  static Future push(BuildContext context, int wordId) async {
    return Navigator.of(context)
        .pushNamed(senseNewPage, arguments: {'wordId': wordId});
  }

  @override
  SenseNewPageState createState() => SenseNewPageState();
}

class SenseNewPageState extends ConsumerState<SenseNewPage> {
  Word? _word;

  bool _isLoading = true;
  bool _isRequesting = false;
  // validatorを利用するために必要なkey
  final _formKey = GlobalKey<FormState>();
  final _glossController = TextEditingController();
  final _sentenceIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      _initialize(arguments);
    });
  }

  // 辞書とキーワードを読み込んでから、loadingを完了する。
  Future _initialize(Map arguments) async {
    final int wordId = arguments['wordId'];
    final Map? resMap = await RemoteSenses.newSense(wordId);
    _isLoading = false;
    if (resMap == null) {
      return setState(() => _isLoading);
    }
    _word = Word.fromJson(resMap['word']);
    setState(() => _isLoading);
  }

  @override
  // widgetの破棄時にコントローラも破棄する。Controllerを使うなら必ず必要。
  // 参考： https://api.flutter.dev/flutter/widgets/TextEditingController-class.html
  void dispose() {
    _glossController.dispose();
    _sentenceIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future save() async {
      // 各Fieldのvalidatorを呼び出す
      if (!_formKey.currentState!.validate()) return;
      // リクエストロック開始
      setState(() {
        _isRequesting = true;
      });

      Map<String, dynamic> params = {
        'gloss': _glossController.text,
        'sentence_id': _sentenceIdController.text,
        'word_id': _word!.id
      };
      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      final Map? resMap = await RemoteSenses.create(params);
      EasyLoading.dismiss();
      // リクエストロック終了
      setState(() {
        _isRequesting = false;
      });
      if (!mounted) return;

      if (resMap == null) {
        const snackBar = SnackBar(content: Text('意味を作成できませんでした。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final sense = Sense.fromJson(resMap['sense']);
        final snackBar = SnackBar(content: Text('${resMap['message']}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        SenseShowPage.pushReplacement(context, sense.id);
      }
    }

    Widget body(Word? word) {
      if (_isLoading) return const LoadingSpinner();
      if (word == null) return const Text('Word does not exist.');
      final Dictionary? dictionary = word.dictionary;
      if (dictionary == null) return const Text('Dictionary does not exist.');

      return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DictionaryName(dictionary: dictionary),
              const SizedBox(height: 16),
              SenseWordEntry(
                word: word,
              ),
              const SizedBox(height: 24),
              SenseForm(
                  glossController: _glossController,
                  sentenceIdController: _sentenceIdController,
                  dictionary: dictionary,
                  keyword: word.entry,
                  isNew: true),
              const SizedBox(height: 40),
              SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity,
                        40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
                  ),
                  // 二重リクエスト防止
                  onPressed: _isRequesting
                      ? null
                      : () async {
                          save();
                        },
                  icon: const Icon(Icons.update, color: Colors.white),
                  label: const Text(
                    '作成する',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ]),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('意味の追加'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: 24,
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: body(_word),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
