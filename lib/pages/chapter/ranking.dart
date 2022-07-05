import 'package:booqs_mobile/data/provider/chapter.dart';
import 'package:booqs_mobile/data/remote/chapters.dart';
import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:booqs_mobile/widgets/user/ranker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChapterRanking extends ConsumerStatefulWidget {
  const ChapterRanking({Key? key}) : super(key: key);

  @override
  _ChapterRankingState createState() => _ChapterRankingState();
}

class _ChapterRankingState extends ConsumerState<ChapterRanking> {
  final List<User> _dailyRankers = [];
  final List<User> _weeklyRankers = [];
  final List<User> _monthlyRankers = [];
  bool _initDone = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _loadRankers();
    });
  }

  Future _loadRankers() async {
    final Chapter? chapter = ref.watch(chapterProvider);
    if (chapter == null) return;
    final Map? resMap = await RemoteChapters.ranking(chapter.publicUid);
    if (resMap == null) return;
    resMap['daily_rankers'].forEach((e) => _dailyRankers.add(User.fromJson(e)));
    resMap['weekly_rankers']
        .forEach((e) => _weeklyRankers.add(User.fromJson(e)));
    resMap['monthly_rankers']
        .forEach((e) => _monthlyRankers.add(User.fromJson(e)));
    setState(() {
      _dailyRankers;
      _weeklyRankers;
      _monthlyRankers;
      _initDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_initDone == false) {
      return const LoadingSpinner();
    }

    Widget _dailyRanking() {
      List<Widget> rankers = [];
      _dailyRankers.asMap().forEach((int i, User user) {
        rankers.add(
          UserRanker(user: user, rank: i + 1, type: 'daily'),
        );
      });
      return Column(
        children: rankers,
      );
    }

    Widget _weeklyRanking() {
      List<Widget> rankers = [];
      _weeklyRankers.asMap().forEach((int i, User user) {
        rankers.add(
          UserRanker(user: user, rank: i + 1, type: 'weekly'),
        );
      });
      return Column(
        children: rankers,
      );
    }

    Widget _monthlyRanking() {
      List<Widget> rankers = [];
      _monthlyRankers.asMap().forEach((int i, User user) {
        rankers.add(
          UserRanker(user: user, rank: i + 1, type: 'monthly'),
        );
      });
      return Column(
        children: rankers,
      );
    }

    Widget _heading(String text) {
      return Text(
        text,
        style: const TextStyle(
            fontSize: 32, color: Colors.green, fontWeight: FontWeight.bold),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 48),
          _heading('今日のランキング'),
          const SizedBox(height: 16),
          _dailyRanking(),
          const SizedBox(height: 48),
          _heading('週間ランキング'),
          const SizedBox(height: 16),
          _weeklyRanking(),
          const SizedBox(height: 48),
          _heading('月間ランキング'),
          _monthlyRanking(),
          const SizedBox(height: 120),
        ],
      ),
    );
  }
}
