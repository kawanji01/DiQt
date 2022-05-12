import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/data/provider/sentence.dart';
import 'package:booqs_mobile/data/remote/sentences.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/pages/sentence/show.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/sentence/form.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceNewPage extends ConsumerStatefulWidget {
  const SentenceNewPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(sentenceNewPage);
  }

  @override
  _SentenceNewPageState createState() => _SentenceNewPageState();
}

class _SentenceNewPageState extends ConsumerState<SentenceNewPage> {
  Dictionary? _dictionary;
  // validatorを利用するために必要なkey
  final _formKey = GlobalKey<FormState>();
  final _originalController = TextEditingController();
  final _translationController = TextEditingController();
  final _explanationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _dictionary = ref.watch(dictionaryProvider);
      setState(() {
        _dictionary;
      });
    });
  }

  @override
  // widgetの破棄時にコントローラも破棄する。Controllerを使うなら必ず必要。
  // 参考： https://api.flutter.dev/flutter/widgets/TextEditingController-class.html
  void dispose() {
    _originalController.dispose();
    _translationController.dispose();
    _explanationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /* Future _moveToSentencePage(sentence) async {
      ref.read(sentenceProvider.notifier).state = sentence;
      await SentenceShowPage.pushReplacement(context);
    } */

    Future _save() async {
      // 各Fieldのvalidatorを呼び出す
      if (!_formKey.currentState!.validate()) return;

      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      Map<String, dynamic> params = {
        'original': _originalController.text,
        'lang_number_of_original': _dictionary!.langNumberOfEntry,
        'translation': _translationController.text,
        'lang_number_of_tranlsation': _dictionary!.langNumberOfMeaning,
        'explanation': _explanationController.text,
        'dictionary_id': _dictionary!.id
      };

      final Map? resMap = await RemoteSentences.create(params);

      if (resMap == null) {
        EasyLoading.dismiss();
        const snackBar = SnackBar(content: Text('辞書を更新できませんでした。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final sentence = Sentence.fromJson(resMap['sentence']);
        final snackBar = SnackBar(content: Text('${resMap['message']}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        SentenceShowPage.pushReplacement(context, sentence.id);
      }
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
            _save(),
          },
          icon: const Icon(Icons.update, color: Colors.white),
          label: const Text(
            '作成する',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      );
    }

    Widget _body() {
      return SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(20),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SentenceForm(
                          originalController: _originalController,
                          translationController: _translationController,
                          explanationController: _explanationController),
                      const SizedBox(height: 40),
                      _submitButton(),
                      const SizedBox(height: 40),
                    ]))),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('例文の追加'),
      ),
      body: _body(),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
