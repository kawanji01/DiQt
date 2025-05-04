import 'package:booqs_mobile/components/dictionary/name.dart';
import 'package:booqs_mobile/components/sentence/form/fields.dart';
import 'package:booqs_mobile/data/provider/sentence.dart';
import 'package:booqs_mobile/data/remote/sentences.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/sentence_request.dart';
import 'package:booqs_mobile/pages/sentence/show.dart';
import 'package:booqs_mobile/pages/sentence_request/show.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceNewScreen extends ConsumerStatefulWidget {
  const SentenceNewScreen(
      {super.key, required this.keyword, required this.dictionary});
  final String keyword;
  final Dictionary dictionary;

  @override
  ConsumerState<SentenceNewScreen> createState() => _SentenceNewScreenState();
}

class _SentenceNewScreenState extends ConsumerState<SentenceNewScreen> {
  late final sentenceControllerMapNotifier =
      ref.read(sentenceControllerMapProvider.notifier);
  bool _isRequesting = false;
  bool _isLoading = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      sentenceControllerMapNotifier.initialize(
        dictionary: widget.dictionary,
        keyword: widget.keyword,
      );
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      sentenceControllerMapNotifier.disposeAllItems();
    });
  }

  Future save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isRequesting = true;
    });

    final params = sentenceControllerMapNotifier.requestParams();
    EasyLoading.show(status: 'loading...');
    final Map resMap = await RemoteSentences.create(
        params: params, comment: params['comment'] ?? '');
    EasyLoading.dismiss();
    setState(() {
      _isRequesting = false;
    });
    if (!mounted) return;
    if (!context.mounted) return;
    if (ErrorHandler.isErrorMap(resMap)) {
      ErrorHandler.showErrorSnackBar(context, resMap);
      return;
    }
    final SentenceRequest sentenceRequest =
        SentenceRequest.fromJson(resMap['sentence_request']);
    final snackBar = SnackBar(content: Text('${resMap['message']}'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    if (sentenceRequest.closed()) {
      final sentence = Sentence.fromJson(resMap['sentence']);
      SentenceShowPage.pushReplacement(context, sentence.id);
    } else {
      SentenceRequestShowPage.pushReplacement(context, sentenceRequest.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Form(
      key: _formKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DictionaryName(dictionary: widget.dictionary, linked: false),
            const SizedBox(height: 32),
            SentenceFormFields(
              dictionary: widget.dictionary,
              isNew: true,
              keyword: widget.keyword,
            ),
            const SizedBox(height: 40),
            SizedBox(
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 40),
                ),
                onPressed: _isRequesting ? null : save,
                icon: const Icon(Icons.update, color: Colors.white),
                label: Text(
                  t.shared.create,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ]),
    );
  }
}
