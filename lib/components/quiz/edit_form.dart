import 'package:booqs_mobile/components/drill/name.dart';
import 'package:booqs_mobile/components/form/editor_comment.dart';
import 'package:booqs_mobile/components/quiz/form/fields.dart';
import 'package:booqs_mobile/data/remote/quizzes.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/quiz_request.dart';
import 'package:booqs_mobile/pages/quiz/show.dart';
import 'package:booqs_mobile/pages/quiz_request/show.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizEditForm extends ConsumerStatefulWidget {
  const QuizEditForm({super.key, required this.quiz});
  final Quiz quiz;

  @override
  ConsumerState<QuizEditForm> createState() => QuizEditFormState();
}

class QuizEditFormState extends ConsumerState<QuizEditForm> {
  late Quiz _quiz;
  bool _isRequesting = false;
  // validatorを利用するために必要なkey
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final _correctAnswerController = TextEditingController();
  final _distractor1Controller = TextEditingController();
  final _distractor2Controller = TextEditingController();
  final _distractor3Controller = TextEditingController();
  final _hintController = TextEditingController();
  final _explanationController = TextEditingController();
  final _appliedDictionaryIdController = TextEditingController();
  final _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _quiz = widget.quiz;
    _questionController.text = _quiz.question;
    _correctAnswerController.text = _quiz.correctAnswer;
    _distractor1Controller.text = _quiz.distractor1 ?? '';
    _distractor2Controller.text = _quiz.distractor2 ?? '';
    _distractor3Controller.text = _quiz.distractor3 ?? '';
    _hintController.text = _quiz.hint ?? '';
    _explanationController.text = _quiz.explanation ?? '';
    _appliedDictionaryIdController.text = '${_quiz.appliedDictionaryId}';
  }

  @override
  // widgetの破棄時にコントローラも破棄する。Controllerを使うなら必ず必要。
  // 参考： https://api.flutter.dev/flutter/widgets/TextEditingController-class.html
  void dispose() {
    super.dispose();
    _questionController.dispose();
    _correctAnswerController.dispose();
    _distractor1Controller.dispose();
    _distractor2Controller.dispose();
    _distractor3Controller.dispose();
    _hintController.dispose();
    _explanationController.dispose();
    _appliedDictionaryIdController.dispose();
    _commentController.dispose();
  }

  Future<void> _save() async {
    // 各Fieldのvalidatorを呼び出す
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isRequesting = true);

    final Map<String, dynamic> params = {
      'id': _quiz.id,
      'question': _questionController.text,
      'correct_answer': _correctAnswerController.text,
      'distractor_1': _distractor1Controller.text,
      'distractor_2': _distractor2Controller.text,
      'distractor_3': _distractor3Controller.text,
      'explanation': _explanationController.text,
      'hint': _hintController.text,
    };
    // 画面全体にローディングを表示
    EasyLoading.show(status: 'loading...');
    final Map resMap = await RemoteQuizzes.update(
        params: params, comment: _commentController.text);
    EasyLoading.dismiss();
    setState(() => _isRequesting = false);
    if (!mounted) return;
    if (ErrorHandler.isErrorMap(resMap)) {
      ErrorHandler.showErrorSnackBar(context, resMap);
      return;
    }
    final QuizRequest quizRequest =
        QuizRequest.fromJson(resMap['quiz_request']);
    final snackBar = SnackBar(content: Text('${resMap['message']}'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    if (quizRequest.closed()) {
      QuizShowPage.pushReplacement(context, _quiz.id);
    } else {
      QuizRequestShowPage.pushReplacement(context, quizRequest.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Drill? drill = _quiz.drill;
    if (drill == null) {
      return const Text('Drill does not exist.');
    }

    return Form(
      key: _formKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 24),
            DrillName(drill: drill),
            const SizedBox(height: 32),
            QuizFormFields(
              questionController: _questionController,
              correctAnswerController: _correctAnswerController,
              distractor1Controller: _distractor1Controller,
              distractor2Controller: _distractor2Controller,
              distractor3Controller: _distractor3Controller,
              explanationController: _explanationController,
              hintController: _hintController,
              appliedDictionaryIdController: _appliedDictionaryIdController,
              quiz: _quiz,
            ),
            const SizedBox(height: 40),
            FormEditorComment(commentController: _commentController),
            const SizedBox(height: 64),
            SizedBox(
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity,
                      40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
                ),
                onPressed: _isRequesting ? null : () => _save(),
                icon: const Icon(Icons.update, color: Colors.white),
                label: Text(
                  t.shared.update,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 80),
          ]),
    );
  }
}
