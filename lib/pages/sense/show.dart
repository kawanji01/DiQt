import 'package:booqs_mobile/components/sense/item.dart';
import 'package:booqs_mobile/components/sense/sense_requests_button.dart';
import 'package:booqs_mobile/components/sense/word_entry.dart';
import 'package:booqs_mobile/data/provider/sense.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/sense.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/dictionary/name.dart';
import 'package:booqs_mobile/components/drill/list_quiz.dart';
import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SenseShowPage extends ConsumerStatefulWidget {
  const SenseShowPage({Key? key}) : super(key: key);

  static Future push(BuildContext context, int senseId) async {
    return Navigator.of(context)
        .pushNamed(senseShowPage, arguments: {'senseId': senseId});
  }

  static Future pushReplacement(BuildContext context, int senseId) async {
    return Navigator.of(context)
        .pushReplacementNamed(senseShowPage, arguments: {'senseId': senseId});
  }

  @override
  SenseShowPageState createState() => SenseShowPageState();
}

class SenseShowPageState extends ConsumerState<SenseShowPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      final int senseId = arguments['senseId'];
      ref.refresh(asyncSenseFamily(senseId));
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final int senseId = arguments['senseId'];
    final future = ref.watch(asyncSenseFamily(senseId));

    Widget quiz(Sense sense) {
      final Quiz? quiz = sense.quiz;
      if (quiz == null) return Container();
      return DrillListQuiz(
        quiz: quiz,
        isShow: false,
      );
    }

    Widget body(Sense? sense) {
      if (sense == null) return const Text('Sense does not exist.');

      final Dictionary? dictionary = sense.dictionary;
      if (dictionary == null) return const Text('Dictionary does not exist.');
      final Word? word = sense.word;
      if (word == null) return const Text('Word does not exist.');
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          DictionaryName(dictionary: dictionary),
          const SizedBox(height: 16),
          SenseWordEntry(
            word: word,
          ),
          const SizedBox(height: 24),
          SenseItem(
            sense: sense,
            isShow: true,
          ),
          SenseSenseRequestsButton(sense: sense),
          const SizedBox(height: 24),
          const Divider(
            thickness: 1,
          ),
          const SizedBox(height: 16),
          quiz(sense),
          const SizedBox(height: 48),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('意味'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: 24,
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: future.when(
            loading: () => const LoadingSpinner(),
            error: (err, stack) => Text('Error: $err'),
            data: (sense) => body(sense),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
