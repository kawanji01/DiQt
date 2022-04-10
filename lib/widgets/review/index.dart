import 'dart:convert';
import 'package:booqs_mobile/data/provider/answer_setting_provider.dart';
import 'package:booqs_mobile/data/provider/current_user_provider.dart';
import 'package:booqs_mobile/data/provider/loaded_quiz_ids.dart';
import 'package:booqs_mobile/data/provider/todays_answers_count_provider.dart';
import 'package:booqs_mobile/data/remote/reviews.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/notifications/loading_unsolved_quizzes.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:booqs_mobile/widgets/review/introduction.dart';
import 'package:booqs_mobile/widgets/review/unsolved_feed.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ReviewIndex extends ConsumerStatefulWidget {
  const ReviewIndex({Key? key}) : super(key: key);

  @override
  _ReviewIndexState createState() => _ReviewIndexState();
}

class _ReviewIndexState extends ConsumerState<ReviewIndex> {
  final List<Review> _reviews = [];
  bool _initDone = false;
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance?.addPostFrameCallback　はすべてのWidgetのビルドが終わったタイミングで呼ばれるコールバック ref: https://zuma-lab.com/posts/flutter-troubleshooting-called-during-build
    // ビルドが終わる前にStateを更新すると setState() or markNeedsBuild() called during build が発生する。
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _loadUnsolvedReviews();
    });
  }

  Future _loadUnsolvedReviews() async {
    final resMap = await RemoteReviews.index(context);

    if (resMap == null) {
      await UserSetup.logOut(null);
      ref.read(currentUserProvider.notifier).state = null;
      ref.read(answerSettingProvider.notifier).state = null;
      ref.read(todaysAnswersCountProvider.notifier).state = 0;
      return setState(() {
        _initDone = true;
      });
    }

    User user = User.fromJson(resMap['user']);
    await UserSetup.signIn(user);
    ref.read(currentUserProvider.notifier).state = user;
    ref.read(answerSettingProvider.notifier).state = user.answerSetting;
    ref.read(todaysAnswersCountProvider.notifier).state =
        user.todaysAnswerHistoriesCount;

    resMap['reviews'].forEach((e) => _reviews.add(Review.fromJson(e)));
    final List<int> loadedQuizIds = _reviews.map((e) => e.quizId).toList();
    ref.read(loadedQuizIdsProvider.notifier).state = loadedQuizIds;
    setState(() {
      _reviews;
      _initDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _reviewFeed() {
      if (_initDone == false) return const LoadingSpinner();

      if (_reviews.isEmpty) {
        return const ReviewIntroduction();
      }
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ReviewUnsolvedFeed(reviews: _reviews),
      );
    }

    return NotificationListener<LoadingUnsolvedQuizzesNotification>(
      onNotification: (notification) {
        // すべてのWeidgetの描画が終わるまで待たないと20件の復習が読み込まれる。
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          _loadUnsolvedReviews();
        });
        // trueを返すことで通知がこれ以上遡らない
        return true;
      },
      child: _reviewFeed(),
    );
  }
}
