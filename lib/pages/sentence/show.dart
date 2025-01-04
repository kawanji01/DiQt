import 'package:booqs_mobile/components/layouts/app_bar/default.dart';
import 'package:booqs_mobile/components/sentence/show_action_buttons.dart';
import 'package:booqs_mobile/components/sentence/show_screen.dart';
import 'package:booqs_mobile/data/provider/sentence.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceShowPage extends ConsumerStatefulWidget {
  const SentenceShowPage({super.key});

  static Future push(BuildContext context, int sentenceId) async {
    return Navigator.of(context)
        .pushNamed(sentenceShowPage, arguments: {'sentenceId': sentenceId});
  }

  static Future pushReplacement(BuildContext context, int sentenceId) async {
    return Navigator.of(context).pushReplacementNamed(sentenceShowPage,
        arguments: {'sentenceId': sentenceId});
  }

  @override
  SentenceShowPageState createState() => SentenceShowPageState();
}

class SentenceShowPageState extends ConsumerState<SentenceShowPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      final int sentenceId = arguments['sentenceId'];
      ref.invalidate(asyncSentenceFamily(sentenceId));
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final int sentenceId = arguments['sentenceId'];

    return Scaffold(
      appBar: AppBarDefault(
        title: t.sentences.sentence,
        actions: [SentenceShowActionButtons(sentenceId: sentenceId)],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
            vertical: 24,
            horizontal: ResponsiveValues.horizontalMargin(context)),
        child: ref.watch(asyncSentenceFamily(sentenceId)).when(
              data: (sentence) {
                if (sentence == null) {
                  return const Text('Sentence does not exist.');
                }
                return SentenceShowScreen(sentence: sentence);
              },
              loading: () => const LoadingSpinner(),
              error: (err, stack) => Text('Error: $err'),
            ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
