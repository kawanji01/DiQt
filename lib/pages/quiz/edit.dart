import 'package:booqs_mobile/data/remote/quizzes.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/pages/quiz/show.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/widgets/drill/name.dart';
import 'package:booqs_mobile/widgets/quiz/form/form.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class QuizEditPage extends StatefulWidget {
  const QuizEditPage({Key? key}) : super(key: key);

  static Future push(BuildContext context, int quizId) async {
    return Navigator.of(context)
        .pushNamed(quizEditPage, arguments: {'quizId': quizId});
  }

  @override
  State<QuizEditPage> createState() => _QuizEditPageState();
}

class _QuizEditPageState extends State<QuizEditPage> {
  Quiz? _quiz;
  bool _isLoading = true;
  // validatorを利用するために必要なkey
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final _correctAnswerController = TextEditingController();
  final _distractorsController = TextEditingController();
  final _hintController = TextEditingController();
  final _explanationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      final int quizId = arguments['quizId'];
      _loadQuiz(quizId);
    });
  }

  Future _loadQuiz(int quizId) async {
    final Map? resMap = await RemoteQuizzes.edit(quizId);
    _isLoading = false;
    if (resMap == null) {
      return setState(() => _isLoading);
    }
    final Quiz? quiz = Quiz.fromJson(resMap['quiz']);
    if (quiz == null) {
      return setState(() => _isLoading);
    }
    _questionController.text = quiz.question;
    _correctAnswerController.text = quiz.correctAnswer;
    _distractorsController.text = quiz.distractors ?? '';
    _hintController.text = quiz.hint ?? '';
    _explanationController.text = quiz.explanation ?? '';
    setState(() {
      _quiz = quiz;
    });
  }

  @override
  // widgetの破棄時にコントローラも破棄する。Controllerを使うなら必ず必要。
  // 参考： https://api.flutter.dev/flutter/widgets/TextEditingController-class.html
  void dispose() {
    _questionController.dispose();
    _correctAnswerController.dispose();
    _distractorsController.dispose();
    _hintController.dispose();
    _explanationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    Future _save(quiz) async {
      // 各Fieldのvalidatorを呼び出す
      if (!_formKey.currentState!.validate()) return;

      final Map<String, dynamic> params = {
        'id': quiz.id,
        'question': _questionController.text,
        'correct_answer': _correctAnswerController.text,
        'distractors': _distractorsController.text,
        'explanation': _explanationController.text,
        'hint': _hintController.text,
      };

      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      final Map? resMap = await RemoteQuizzes.update(params);
      EasyLoading.dismiss();

      if (resMap == null) {
        const snackBar = SnackBar(content: Text('問題を更新できませんでした。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final int quizId = resMap['quiz']['id'];
        final snackBar = SnackBar(content: Text('${resMap['message']}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        QuizShowPage.pushReplacement(context, quizId);
      }
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
            _save(_quiz),
          },
          icon: const Icon(Icons.update, color: Colors.white),
          label: const Text(
            '更新する',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      );
    }

    //
    Widget _body(Quiz? quiz) {
      if (_isLoading) return const LoadingSpinner();
      if (quiz == null) return const Text('Quiz does not exist.');
      final Drill? drill = quiz.drill;
      if (drill == null) return const Text('Drill does not exist.');

      return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 24),
              DrillName(drill: drill),
              const SizedBox(height: 32),
              QuizForm(
                  questionController: _questionController,
                  correctAnswerController: _correctAnswerController,
                  distractorsController: _distractorsController,
                  explanationController: _explanationController,
                  hintController: _hintController,
                  quiz: quiz,
                  dictionary: quiz.dictionary!),
              const SizedBox(height: 40),
              _submitButton(),
              const SizedBox(height: 40),
            ]),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('問題の編集'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: _body(_quiz),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
