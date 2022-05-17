import 'package:booqs_mobile/data/provider/sentence.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/dictionary/name.dart';
import 'package:booqs_mobile/widgets/drill/list_quiz.dart';
import 'package:booqs_mobile/widgets/sentence/item_with_review_button.dart';
import 'package:booqs_mobile/widgets/sentence/sentence_requests_button.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceShowPage extends ConsumerStatefulWidget {
  const SentenceShowPage({Key? key}) : super(key: key);

  static Future push(BuildContext context, int sentenceId) async {
    return Navigator.of(context)
        .pushNamed(sentenceShowPage, arguments: {'sentenceId': sentenceId});
  }

  static Future pushReplacement(BuildContext context, int sentenceId) async {
    return Navigator.of(context).pushReplacementNamed(sentenceShowPage,
        arguments: {'sentenceId': sentenceId});
  }

  @override
  _SentenceShowPageState createState() => _SentenceShowPageState();
}

class _SentenceShowPageState extends ConsumerState<SentenceShowPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      final int sentenceId = arguments['sentenceId'];
      ref.refresh(asyncSentenceFamily(sentenceId));
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final int sentenceId = arguments['sentenceId'];
    final future = ref.watch(asyncSentenceFamily(sentenceId));

    Widget _body(Sentence? sentence) {
      if (sentence == null) return const Text('Sentence does not exist.');
      final Quiz? quiz = sentence.quiz;
      if (quiz == null) return const Text('Quiz does not exist.');
      final Dictionary? dictionary = sentence.dictionary;
      if (dictionary == null) return const Text('Dictionary does not exist.');
      return SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  DictionaryName(dictionary: dictionary),
                  const SizedBox(height: 24),
                  SentenceItemWithReviewButton(
                    sentence: sentence,
                    isShow: true,
                  ),
                  SentenceSentenceRequestsButton(sentence: sentence),
                  const SizedBox(height: 24),
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(height: 16),
                  DrillListQuiz(
                    quiz: quiz,
                    isShow: false,
                  ),
                  const SizedBox(height: 48),
                ],
              )));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('例文'),
      ),
      body: future.when(
        loading: () => const LoadingSpinner(),
        error: (err, stack) => Text('Error: $err'),
        data: (sentence) => _body(sentence),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
