import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/error/scaffold_404.dart';
import 'package:booqs_mobile/components/quiz_request/dictionary/screen.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizRequestDictionaryPage extends ConsumerStatefulWidget {
  const QuizRequestDictionaryPage({super.key});

  static Future push(
      BuildContext context, int dictionaryId, String type) async {
    return Navigator.of(context).pushNamed(
      quizRequestDictionaryPage,
      arguments: {
        'dictionaryId': dictionaryId,
        'type': type,
      },
    );
  }

  static Future pushReplacement(
      BuildContext context, int dictionaryId, String type) async {
    return Navigator.of(context).pushReplacementNamed(
      quizRequestDictionaryPage,
      arguments: {
        'dictionaryId': dictionaryId,
        'type': type,
      },
    );
  }

  @override
  QuizRequestDictionaryPageState createState() =>
      QuizRequestDictionaryPageState();
}

class QuizRequestDictionaryPageState
    extends ConsumerState<QuizRequestDictionaryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int? dictionaryId = args['dictionaryId'];
    final String? type = args['type'];
    if (dictionaryId == null || type == null) {
      return ErrorScaffold404(appBarTitle: t.wordRequests.edit_histories);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(t.wordRequests.edit_histories),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          HapticFeedback.mediumImpact();
          ref.invalidate(asyncDictionaryFamily(dictionaryId));
        },
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: 24,
                horizontal: ResponsiveValues.horizontalMargin(context)),
            child: ref.watch(asyncDictionaryFamily(dictionaryId)).when(
                data: (dictionary) {
                  if (dictionary == null) {
                    return const Text('Dictionary does not exist.');
                  }
                  return QuizRequestDictionaryScreen(
                      dictionary: dictionary, type: type);
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
