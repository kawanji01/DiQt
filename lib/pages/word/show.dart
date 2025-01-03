import 'package:booqs_mobile/components/layouts/app_bar/default.dart';
import 'package:booqs_mobile/components/word/show_action.dart';
import 'package:booqs_mobile/data/provider/word.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/word/preloaded_show_screen.dart';
import 'package:booqs_mobile/components/word/show_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordShowPage extends ConsumerStatefulWidget {
  const WordShowPage({super.key});

  // メモ：遷移の処理は、いちいち描き直す必要はないので、createStateの上に置く。
  static Future push(BuildContext context, int wordId) async {
    return Navigator.of(context)
        .pushNamed(wordShowPage, arguments: {'wordId': wordId});
  }

  // 戻らせない画面遷移
  static Future pushReplacement(BuildContext context, int wordId) async {
    return Navigator.of(context)
        .pushReplacementNamed(wordShowPage, arguments: {'wordId': wordId});
  }

  @override
  WordShowPageState createState() => WordShowPageState();
}

class WordShowPageState extends ConsumerState<WordShowPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      final int wordId = arguments['wordId'];
      ref.invalidate(asyncWordFamily(wordId));
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final int wordId = arguments['wordId'];
    final Word? word = ref.watch(wordProvider);
    final future = ref.watch(asyncWordFamily(wordId));

    Widget action() {
      return future.when(
        data: (date) => WordShowAction(word: date),
        error: (err, stack) => Container(),
        loading: () => WordShowAction(word: word),
      );
    }

    return Scaffold(
      appBar: AppBarDefault(
        title: future.when(
          data: (date) => date?.entry ?? '',
          error: (err, stack) => 'Error',
          loading: () => word?.entry ?? '',
        ),
        actions: [action()],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          HapticFeedback.mediumImpact();
          ref.invalidate(asyncWordFamily(wordId));
        },
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: 24,
                horizontal: ResponsiveValues.horizontalMargin(context)),
            child: future.when(
              data: (data) => WordShowScreen(word: data!),
              error: (err, stack) => Text('Error: $err'),
              loading: () => WordPreloadedShowScreen(word: word),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
