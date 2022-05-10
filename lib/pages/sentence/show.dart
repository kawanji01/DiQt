import 'package:booqs_mobile/data/provider/sentence.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/drill/list_quiz.dart';
import 'package:booqs_mobile/widgets/sentence/edit_button.dart';
import 'package:booqs_mobile/widgets/sentence/item.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceShowPage extends ConsumerStatefulWidget {
  const SentenceShowPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(sentenceShowPage);
  }

  static Future pushReplacement(BuildContext context) async {
    return Navigator.of(context).pushReplacementNamed(sentenceShowPage);
  }

  @override
  _SentenceShowPageState createState() => _SentenceShowPageState();
}

class _SentenceShowPageState extends ConsumerState<SentenceShowPage> {
  @override
  void initState() {
    super.initState();
    ref.refresh(asyncSentenceProvider);
  }

  @override
  Widget build(BuildContext context) {
    final Sentence? _sentence = ref.watch(sentenceProvider);
    final future = ref.watch(asyncSentenceProvider);

    Widget _body(Sentence? sentence) {
      if (sentence == null) return const Text('Sentence does not exist.');
      final Quiz? quiz = sentence.quiz;
      if (quiz == null) return const Text('Quiz does not exist.');
      return SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  SentenceItem(sentence: sentence),
                  const SizedBox(height: 24),
                  SentenceEditButton(sentence: sentence, isShow: true),
                  const SizedBox(height: 24),
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(height: 16),
                  DrillListQuiz(quiz: quiz),
                  const SizedBox(height: 48),
                ],
              )));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('例文の編集'),
      ),
      body: future.when(
        loading: () => _body(_sentence),
        error: (err, stack) => Text('Error: $err'),
        data: (sentence) => _body(sentence),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
