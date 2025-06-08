import 'package:booqs_mobile/components/dictionary/search_info.dart';
import 'package:booqs_mobile/components/layouts/app_bar/default.dart';
import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/dictionary/word_list_view.dart';
import 'package:booqs_mobile/components/dictionary/word_search_results_action.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booqs_mobile/components/shared/review_onboarding.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/remote/users.dart';
import 'package:booqs_mobile/models/user.dart';

// NOTE: 引数を dictionary ではなく dictionaryId にしているのは、DiQtMarkdownの辞書リンクからでも遷移できるようにするため。
class DictionaryWordSearchResultsPage extends ConsumerStatefulWidget {
  const DictionaryWordSearchResultsPage({super.key});

  static Future push(
      BuildContext context, int dictionaryId, String keyword) async {
    return Navigator.of(context).pushNamed(dictionaryWordSearchResultsPage,
        arguments: {'dictionaryId': dictionaryId, 'keyword': keyword});
  }

  static Future pushReplacement(
      BuildContext context, int dictionaryId, String keyword) async {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        // 画面遷移のログを送信するために、settings.nameを設定する。
        settings: RouteSettings(
            name: reviewIndexPage,
            arguments: {'dictionaryId': dictionaryId, 'keyword': keyword}),
        pageBuilder: (context, animation1, animation2) =>
            const DictionaryWordSearchResultsPage(),
        transitionDuration: Duration.zero,
      ),
    );
  }

  @override
  DictionaryWordSearchResultsPageState createState() =>
      DictionaryWordSearchResultsPageState();
}

class DictionaryWordSearchResultsPageState
    extends ConsumerState<DictionaryWordSearchResultsPage> {
  bool _onboardingShown = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      final int dictionaryId = arguments['dictionaryId'];
      ref.invalidate(asyncDictionaryFamily(dictionaryId));
    });
  }

  // 復習のオンボーディングモーダルを表示する
  Future<void> _showOnboardingIfNeeded(User? user) async {
    if (user != null &&
        user.reviewOnboardingShown == false &&
        !_onboardingShown) {
      _onboardingShown = true;
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const ReviewOnboarding(),
      );
      final resMap = await RemoteUsers.updateReviewOnboardingShown();
      if (resMap['user'] != null) {
        final updatedUser = User.fromJson(resMap['user']);
        ref.read(currentUserProvider.notifier).update(updatedUser);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final int dictionaryId = arguments['dictionaryId'];
    final String keyword = arguments['keyword'];
    final future = ref.watch(asyncDictionaryFamily(dictionaryId));
    final user = ref.watch(currentUserProvider);
    // Show onboarding if needed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showOnboardingIfNeeded(user);
    });

    Widget actions() {
      return future.when(
          data: (dictionary) {
            if (dictionary == null) {
              return Container();
            }
            return DictionaryWordSearchResultsAction(
              keyword: keyword,
              dictionary: dictionary,
            );
          },
          error: (e, str) => Container(),
          loading: () => Container());
    }

    Widget dictionary() {
      return future.when(
          data: (dictionary) {
            if (dictionary == null) return Container();
            return DictionarySearchInfo(
                dictionary: dictionary, keyword: keyword);
          },
          error: (e, str) => Text('$e'),
          loading: () => Container());
    }

    return Scaffold(
      appBar: AppBarDefault(
        title: t.dictionaries.search_results,
        actions: [
          actions(),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: ResponsiveValues.horizontalMargin(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                dictionary(),
                const SizedBox(height: 24),
                DictionaryWordListView(
                  dictionaryId: dictionaryId,
                  keyword: keyword,
                ),
              ],
            )),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
