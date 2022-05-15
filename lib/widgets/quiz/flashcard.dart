import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizFlashcard extends ConsumerWidget {
  const QuizFlashcard({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(currentUserProvider);

    void _answer(bool correct) {
      HapticFeedback.mediumImpact();
      AnswerNotification('', correct, quiz, user!, true).dispatch(context);
    }

    Widget _correctButton() {
      return Container(
        padding: const EdgeInsets.only(right: 8),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            minimumSize: const Size(double.infinity,
                40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
          ),
          onPressed: () => {
            _answer(true),
          },
          icon: const Icon(Icons.circle_outlined, color: Colors.white),
          label: const Text(
            '正解した',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
          ),
        ),
      );
    }

    Widget _incorrectButton() {
      return Container(
        padding: const EdgeInsets.only(left: 8),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            minimumSize: const Size(double.infinity,
                40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
          ),
          onPressed: () => {
            _answer(false),
          },
          icon: const Icon(Icons.close, color: Colors.white),
          label: const Text(
            '間違えた',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
          ),
        ),
      );
    }

    Widget _answerButtons() {
      return Row(
        children: [
          Expanded(flex: 1, child: _correctButton()),
          Expanded(flex: 1, child: _incorrectButton()),
        ],
      );
    }

    Widget _content() {
      return Column(
        children: [
          Text(quiz.correctAnswer,
              style:
                  const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          _answerButtons(),
        ],
      );
    }

    return ExpansionTile(
      title: const Text(
        'タップして答えを表示する',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      //collapsedBackgroundColor: const Color(0xfff3f3f4),
      collapsedBackgroundColor: Colors.grey.shade200,
      children: <Widget>[
        _content(),
      ],
    );
  }
}
