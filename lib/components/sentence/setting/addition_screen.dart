import 'package:booqs_mobile/components/button/small_outline_red_button.dart';
import 'package:booqs_mobile/components/sentence/form/fields.dart';
import 'package:booqs_mobile/data/provider/sentence.dart';
import 'package:booqs_mobile/data/remote/sentences.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/sentence_request.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceSettingAdditionScreen extends ConsumerStatefulWidget {
  const SentenceSettingAdditionScreen(
      {super.key, required this.dictionary, required this.keyword});
  final Dictionary dictionary;
  final String keyword;

  @override
  ConsumerState<SentenceSettingAdditionScreen> createState() =>
      _SentenceSettingAdditionScreenState();
}

class _SentenceSettingAdditionScreenState
    extends ConsumerState<SentenceSettingAdditionScreen> {
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

  Future _save() async {
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
      Navigator.of(context).pop();
      Navigator.of(context).pop({'set': sentence});
    } else {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    SizeConfig().init(context);
    final double grid = SizeConfig.blockSizeVertical ?? 0;
    final double height = grid * 80;

    return SizedBox(
      height: height,
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: 24,
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
                      onPressed: _isRequesting ? null : _save,
                      icon: const Icon(Icons.update, color: Colors.white),
                      label: Text(
                        t.shared.create,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SmallOutlineRedButton(
                        label: t.shared.cancel,
                        icon: Icons.cancel_outlined,
                      )),
                  const SizedBox(height: 48),
                ]),
          ),
        ),
      ),
    );
  }
}
