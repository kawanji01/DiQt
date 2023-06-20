import 'package:booqs_mobile/data/remote/sentences.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/pages/sentence/show.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/dictionary/name.dart';
import 'package:booqs_mobile/components/sentence/form.dart';
import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceNewPage extends ConsumerStatefulWidget {
  const SentenceNewPage({Key? key}) : super(key: key);

  static Future push(
      BuildContext context, int dictionaryId, String keyword) async {
    return Navigator.of(context).pushNamed(sentenceNewPage,
        arguments: {'dictionaryId': dictionaryId, 'keyword': keyword});
  }

  @override
  SentenceNewPageState createState() => SentenceNewPageState();
}

class SentenceNewPageState extends ConsumerState<SentenceNewPage> {
  Dictionary? _dictionary;
  String _keyword = '';
  bool _isLoading = true;
  bool _isRequesting = false;
  // validatorを利用するために必要なkey
  final _formKey = GlobalKey<FormState>();
  final _originalController = TextEditingController();
  final _translationController = TextEditingController();
  final _explanationController = TextEditingController();

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
    _keyword = arguments['keyword'];
    final int dictionaryId = arguments['dictionaryId'];
    final Map? resMap = await RemoteSentences.newSentence(dictionaryId);
    _isLoading = false;
    if (resMap == null) {
      return setState(() => _isLoading);
    }
    _dictionary = Dictionary.fromJson(resMap['dictionary']);
    setState(() => _isLoading);
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
    Future save() async {
      // 各Fieldのvalidatorを呼び出す
      if (!_formKey.currentState!.validate()) return;
      // リクエストロック開始
      setState(() {
        _isRequesting = true;
      });

      Map<String, dynamic> params = {
        'original': _originalController.text,
        'translation': _translationController.text,
        'explanation': _explanationController.text,
        'dictionary_id': _dictionary!.id
      };
      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      final Map? resMap = await RemoteSentences.create(params);
      EasyLoading.dismiss();
      // リクエストロック終了
      setState(() {
        _isRequesting = false;
      });
      if (!mounted) return;

      if (resMap == null) {
        const snackBar = SnackBar(content: Text('辞書を更新できませんでした。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final sentence = Sentence.fromJson(resMap['sentence']);
        final snackBar = SnackBar(content: Text('${resMap['message']}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        SentenceShowPage.pushReplacement(context, sentence.id);
      }
    }

    // 更新ボタン
    Widget submitButton() {
      return SizedBox(
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
          label: Text(
            t.shared.create,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      );
    }

    Widget body() {
      if (_isLoading) return const LoadingSpinner();
      if (_dictionary == null) return const Text('Dictionary does not exist.');

      return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DictionaryName(dictionary: _dictionary!),
              const SizedBox(height: 32),
              SentenceForm(
                originalController: _originalController,
                translationController: _translationController,
                explanationController: _explanationController,
                dictionary: _dictionary!,
                isNew: true,
                keyword: _keyword,
              ),
              const SizedBox(height: 40),
              submitButton(),
              const SizedBox(height: 40),
            ]),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('例文の追加'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: 24,
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: body(),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
