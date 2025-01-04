import 'package:booqs_mobile/data/provider/school.dart';
import 'package:booqs_mobile/data/remote/schools.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/school.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/components/user/ranker.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchoolRanking extends ConsumerStatefulWidget {
  const SchoolRanking({super.key});

  @override
  SchoolRankingState createState() => SchoolRankingState();
}

class SchoolRankingState extends ConsumerState<SchoolRanking> {
  final List<User> _dailyRankers = [];
  final List<User> _weeklyRankers = [];
  final List<User> _monthlyRankers = [];
  bool _initDone = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadRankers();
    });
  }

  Future _loadRankers() async {
    final School? school = ref.read(schoolProvider);
    if (school == null) return;
    final Map resMap = await RemoteSchools.ranking(school.publicUid);
    // エラーの場合の処理
    if (ErrorHandler.isErrorMap(resMap)) return;
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

    Widget dailyRanking() {
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

    Widget weeklyRanking() {
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

    Widget monthlyRanking() {
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

    Widget heading(String text) {
      return Text(
        text,
        style: const TextStyle(
            fontSize: 28, color: Colors.green, fontWeight: FontWeight.bold),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 48),
          heading(t.ranking.daily_answerer),
          const SizedBox(height: 16),
          dailyRanking(),
          const SizedBox(height: 48),
          heading(t.ranking.weekly_answerer),
          const SizedBox(height: 16),
          weeklyRanking(),
          const SizedBox(height: 48),
          heading(t.ranking.monthly_answerer),
          monthlyRanking(),
          const SizedBox(height: 120),
        ],
      ),
    );
  }
}
