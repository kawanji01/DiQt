import 'dart:convert';

import 'package:booqs_mobile/data/provider/loaded_quiz_ids.dart';
import 'package:booqs_mobile/data/provider/solved_quiz_ids_provider.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/notifications/loading_unsolved_quizzes.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
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
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');

    if (token == null) {
      return setState(() {
        _initDone = true;
      });
    }

    Uri url = Uri.parse(
        '${DiQtURL.root(context)}/api/v1/mobile/reviews?token=$token');
    http.Response res = await http.get(url);

    if (res.statusCode != 200) {
      await UserSetup.logOut();
      return setState(() {
        _initDone = true;
      });
    }

    Map resMap = json.decode(res.body);
    await UserSetup.signIn(resMap);
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

      return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ReviewUnsolvedFeed(reviews: _reviews),
      );
    }

    return NotificationListener<LoadingUnsolvedQuizzesNotification>(
      onNotification: (notification) {
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          final int solvedQuizIdsCount =
              ref.watch(solvedQuizIdsProvider).length;
          // 少なくとも１問解いていることを条件にする。そうでないとinitialize時にも問題が全問解答と判断されて読み込みが始まる。
          print(solvedQuizIdsCount);
          //if (solvedQuizIdsCount > 0) {
          _loadUnsolvedReviews();
          //}
        });
        // trueを返すことで通知がこれ以上遡らない
        return true;
      },
      child: _reviewFeed(),
    );
  }
}
