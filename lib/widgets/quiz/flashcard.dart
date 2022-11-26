import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:booqs_mobile/widgets/markdown/markdown_without_dict_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizFlashcard extends ConsumerStatefulWidget {
  const QuizFlashcard({Key? key, required this.quiz, required this.unsolved})
      : super(key: key);
  final Quiz quiz;
  final bool unsolved;

  @override
  _QuizFlashcardState createState() => _QuizFlashcardState();
}

class _QuizFlashcardState extends ConsumerState<QuizFlashcard> {
  bool _isDisabled = false;

  @override
  Widget build(BuildContext context) {
    final Quiz _quiz = widget.quiz;
    final bool _unsolved = widget.unsolved;
    final User? _user = ref.watch(currentUserProvider);

    void _answer(bool correct) async {
      if (_isDisabled) return;
      HapticFeedback.mediumImpact();
      AnswerNotification('', correct, _quiz, _user!, true).dispatch(context);
      setState(() => _isDisabled = true);
      if (_unsolved) return;
      // 未解答画面でないなら、１秒間タップできないようにしてから有効化する。
      await Future.delayed(
        const Duration(seconds: 1),
      );
      setState(() => _isDisabled = false);
    }

    Widget _correctButton() {
      return Container(
        padding: const EdgeInsets.only(right: 8),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
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
            backgroundColor: Colors.red,
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

    return ExpansionTile(
      title: const Text(
        'タップして答えを表示する',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      //collapsedBackgroundColor: const Color(0xfff3f3f4),
      collapsedBackgroundColor: Colors.grey.shade200,
      children: <Widget>[
        Column(
          children: [
            // 答え
            MarkdownWithoutDictLink(
              text: _quiz.correctAnswer,
              fontSize: 17,
              fontColor: Colors.black87,
              fontWeight: FontWeight.bold,
              selectable: true,
            ),
            const SizedBox(height: 32),
            // 解答ボタン
            Row(
              children: [
                Expanded(flex: 1, child: _correctButton()),
                Expanded(flex: 1, child: _incorrectButton()),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
