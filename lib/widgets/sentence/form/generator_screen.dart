import 'package:booqs_mobile/data/remote/sentences.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:booqs_mobile/widgets/shared/item_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SentenceFormGeneratorScreen extends StatefulWidget {
  const SentenceFormGeneratorScreen(
      {Key? key,
      required this.langNumber,
      required this.originalController,
      required this.keywordController,
      required this.temperatureController})
      : super(key: key);
  final int langNumber;
  final TextEditingController originalController;
  final TextEditingController keywordController;
  final TextEditingController temperatureController;

  @override
  State<SentenceFormGeneratorScreen> createState() =>
      _SentenceFormGeneratorScreenState();
}

class _SentenceFormGeneratorScreenState
    extends State<SentenceFormGeneratorScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isRequesting = false;
  double _currentSliderValue = 7;

  @override
  void initState() {
    _currentSliderValue = double.parse(widget.temperatureController.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double grid = SizeConfig.blockSizeVertical ?? 0;
    final double height = grid * 80;
    final TextEditingController originalController = widget.originalController;
    final TextEditingController keywordController = widget.keywordController;
    final TextEditingController temperatureController =
        widget.temperatureController;
    final int langNumber = widget.langNumber;

    Future _generate() async {
      // 各Fieldのvalidatorを呼び出す
      if (!_formKey.currentState!.validate()) return;
      // リクエストロック開始
      setState(() {
        _isRequesting = true;
      });

      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      final Map? resMap = await RemoteSentences.generate(
          keywordController.text, langNumber, temperatureController.text);
      EasyLoading.dismiss();
      // リクエストロック終了
      setState(() {
        _isRequesting = false;
      });

      if (resMap == null) {
        const snackBar = SnackBar(content: Text('例文が生成できませんでした。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final String? original = resMap['original'];
        originalController.text = original ?? '';
        const snackBar = SnackBar(content: Text('例文が生成されました。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pop(context);
      }
    }

    return Container(
      height: height,
      padding: EdgeInsets.symmetric(
          horizontal: ResponsiveValues.horizontalMargin(context)),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  const Text('AIで例文を生成する',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 16,
                  ),
                  // 項目フォーム
                  TextFormField(
                    controller: keywordController,
                    decoration: InputDecoration(
                      labelText: '例文に含めるキーワード',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          keywordController.clear();
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'キーワードは空欄にできません。';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),

                  ExpansionTile(
                    title: const Text(
                      '詳細設定',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    //collapsedBackgroundColor: const Color(0xfff3f3f4),
                    collapsedBackgroundColor: Colors.grey.shade200,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          // Temperatur
                          const SharedItemLabel(text: '単語のランダム性（Temperature）'),
                          const SizedBox(height: 8),
                          const Text(
                              '0~20の間で設定します。数値が高いほど単語のランダム性が上がり、数値が低いほど確定的な文章を生成します。デフォルトは７です。',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.normal)),
                          const SizedBox(height: 16),
                          Slider(
                            value: _currentSliderValue,
                            max: 20,
                            min: 0,
                            divisions: 20,
                            label: _currentSliderValue.round().toString(),
                            onChanged: (double value) {
                              temperatureController.text = '$value';
                              setState(() {
                                _currentSliderValue = value;
                              });
                            },
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity,
                          48), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
                    ),
                    onPressed: _isRequesting
                        ? null
                        : () async {
                            _generate();
                          },
                    icon: const Icon(Icons.auto_fix_high, color: Colors.white),
                    label: const Text(
                      '生成する',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
