import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/error/scaffold_404.dart';
import 'package:booqs_mobile/components/sentence_request/sentence/screen.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/data/provider/sentence.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceRequestSentencePage extends ConsumerStatefulWidget {
  const SentenceRequestSentencePage({super.key});

  static Future push(BuildContext context, int sentenceId, String type) async {
    return Navigator.of(context).pushNamed(
      sentenceRequestSentencePage,
      arguments: {
        'sentenceId': sentenceId,
        'type': type,
      },
    );
  }

  static Future pushReplacement(
      BuildContext context, int sentenceId, String type) async {
    return Navigator.of(context).pushReplacementNamed(
      sentenceRequestSentencePage,
      arguments: {
        'sentenceId': sentenceId,
        'type': type,
      },
    );
  }

  @override
  SentenceRequestSentencePageState createState() =>
      SentenceRequestSentencePageState();
}

class SentenceRequestSentencePageState
    extends ConsumerState<SentenceRequestSentencePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int? sentenceId = args['sentenceId'];
    final String? type = args['type'];
    if (sentenceId == null || type == null) {
      return ErrorScaffold404(appBarTitle: t.wordRequests.edit_histories);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(t.wordRequests.edit_histories),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          HapticFeedback.mediumImpact();
          ref.invalidate(asyncSentenceFamily(sentenceId));
        },
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: 24,
                horizontal: ResponsiveValues.horizontalMargin(context)),
            child: ref.watch(asyncSentenceFamily(sentenceId)).when(
                data: (sentence) {
                  if (sentence == null) {
                    return const Text('Sentence does not exist.');
                  }
                  return SentenceRequestSentenceScreen(
                      sentence: sentence, type: type);
                },
                error: (e, str) => Text('error:$e'),
                loading: () => const LoadingSpinner()),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
