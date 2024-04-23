import 'package:booqs_mobile/components/button/medium_green_button.dart';
import 'package:booqs_mobile/components/heading/medium_green.dart';
import 'package:booqs_mobile/components/quiz/form/correct_answer.dart';
import 'package:booqs_mobile/components/quiz/form/question.dart';
import 'package:booqs_mobile/components/sentence/form/ai_model.dart';
import 'package:booqs_mobile/data/remote/quizzes.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class QuizFormDistractorsGeneratorScreen extends StatefulWidget {
  const QuizFormDistractorsGeneratorScreen(
      {super.key,
      required this.questionController,
      required this.correctAnswerController,
      required this.aiModelController,
      required this.distractor1Controller,
      required this.distractor2Controller,
      required this.distractor3Controller});

  final TextEditingController questionController;
  final TextEditingController correctAnswerController;
  final TextEditingController aiModelController;
  final TextEditingController distractor1Controller;
  final TextEditingController distractor2Controller;
  final TextEditingController distractor3Controller;
  @override
  State<QuizFormDistractorsGeneratorScreen> createState() =>
      _QuizFormDistractorsGeneratorScreenState();
}

class _QuizFormDistractorsGeneratorScreenState
    extends State<QuizFormDistractorsGeneratorScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isRequesting = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double grid = SizeConfig.blockSizeVertical ?? 0;
    final double height = grid * 80;
    final TextEditingController questionController = widget.questionController;
    final TextEditingController correctAnswerController =
        widget.correctAnswerController;
    final TextEditingController aiModelController = widget.aiModelController;

    Future generate() async {
      // 各Fieldのvalidatorを呼び出す
      if (!_formKey.currentState!.validate()) return;
      // リクエストロック開始
      setState(() {
        _isRequesting = true;
      });

      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      final Map resMap = await RemoteQuizzes.generateDistractors(
        question: questionController.text,
        correctAnswer: correctAnswerController.text,
        model: aiModelController.text,
      );
      EasyLoading.dismiss();
      // リクエストロック終了
      setState(() {
        _isRequesting = false;
      });
      if (!context.mounted) return;
      if (ErrorHandler.isErrorMap(resMap)) {
        ErrorHandler.showErrorSnackBar(context, resMap);
        Navigator.pop(context);
      } else {
        widget.distractor1Controller.text = resMap['distractor_1'] ?? '';
        widget.distractor2Controller.text = resMap['distractor_2'] ?? '';
        widget.distractor3Controller.text = resMap['distractor_3'] ?? '';
        final snackBar =
            SnackBar(content: Text(t.quizzes.distractors_generated));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context).pop();
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
                  HeadingMediumGreen(
                    label: t.quizzes.generate_distractors,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  QuizFormQuestion(questionController: questionController),
                  const SizedBox(
                    height: 40,
                  ),
                  QuizFormCorrectAnswer(
                      correctAnswerController: correctAnswerController),
                  const SizedBox(
                    height: 48,
                  ),
                  // AIモデル
                  SentenceFormAIModel(
                    aiModelController: aiModelController,
                  ),

                  const SizedBox(height: 64),
                  InkWell(
                    onTap: _isRequesting
                        ? null
                        : () async {
                            generate();
                          },
                    child: MediumGreenButton(
                      fontSize: 18,
                      icon: Icons.auto_fix_high,
                      label: t.shared.generate,
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
