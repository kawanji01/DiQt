import 'package:booqs_mobile/notification/answer.dart';
import 'package:booqs_mobile/utils/answer_interaction.dart';
import 'package:flutter/material.dart';

class QuizUnsolvedContent extends StatefulWidget {
  const QuizUnsolvedContent(
      {Key? key,
      required this.header,
      required this.question,
      required this.answer,
      required this.footer})
      : super(key: key);

  final Widget header;
  final Widget question;
  final Widget answer;
  final Widget footer;

  @override
  State<QuizUnsolvedContent> createState() => _QuizUnsolvedContentState();
}

class _QuizUnsolvedContentState extends State<QuizUnsolvedContent> {
  bool _isVisible = true;
  bool _isOpaque = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<AnswerNotification>(
      onNotification: (notification) {
        final fadeOut = notification.fadeOut;
        AnswerInteraction.show(notification, context);
        if (fadeOut) {
          setState(() {
            _isOpaque = false;
          });
        }
        // trueを返すことで通知がこれ以上遡らない
        return true;
      },
      // FadeOutで問題を隠す & 高さも消失させる ref: https://stackoverflow.com/questions/58493886/animated-opacity-and-hiding-the-widget-so-its-not-clickable
      child: AnimatedOpacity(
        opacity: _isOpaque ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 800),
        onEnd: () {
          if (_isOpaque == false) {
            setState(() {
              _isVisible = false;
            });
          }
        },
        // 必ずコンテンツは外から渡す。
        // そうしないと、コンテンツが解かれて消えるまでにコンテンツがリビルドされて、選択肢が一瞬ランダムに表示されるなど不細工なことになる。
        child: Visibility(
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black12,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 8),
                widget.header,
                widget.question,
                const SizedBox(height: 16),
                widget.answer,
                const SizedBox(height: 8),
                widget.footer,
                const SizedBox(height: 8),
              ],
            ),
          ),
          visible: _isVisible,
        ),
      ),
    );
  }
}
