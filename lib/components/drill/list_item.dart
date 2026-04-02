import 'package:booqs_mobile/components/drill/thumbnail.dart';
import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/drill_lap.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/drill/unsolved.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/diqt_browser_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

enum _ExamAccessStatus { notStarted, ongoing, expired }

class DrillListItem extends ConsumerWidget {
  const DrillListItem({super.key, required this.drill});
  final Drill drill;

  static const Duration _tokyoOffset = Duration(hours: 9);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1,000のようなdelimiterを使って解答数を整形する。参考： https://stackoverflow.com/questions/62580280/how-to-format-numbers-as-thousands-separators-in-dart

    String answerHistoriesCountText = '';
    // 1000以下の回答数は表示しない。
    if (drill.answerHistoriesCount > 1000) {
      final formatter = NumberFormat('#,###,000');
      final answerHistoriesCount = formatter.format(drill.answerHistoriesCount);
      answerHistoriesCountText = t.drills.answers(number: answerHistoriesCount);
    }
    final DrillLap? drillLap = drill.drillLap;
    final _ExamAccessStatus? examAccessStatus = _buildExamAccessStatus();

    // Drillページに遷移
    void moveToDrillPage(drill) {
      final User? user = ref.watch(currentUserProvider);
      if (user == null) {
        final snackBar = SnackBar(content: Text(t.shared.login_recommendation));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        UserMyPage.push(context);
      } else {
        if (drill.examMode) {
          DiQtBrowserDialog.open(
              context, '/drills/${drill.publicUid}/unsolved');
        } else {
          ref.read(drillProvider.notifier).state = drill;
          DrillUnsolvedPage.push(context);
        }
      }
    }

    Widget? subtitle() {
      final String clearsCountText = drillLap == null
          ? ''
          : t.drills.clears_count(number: drillLap.clearsCount);
      final String subtitleText;

      if (answerHistoriesCountText.isNotEmpty && clearsCountText.isNotEmpty) {
        subtitleText = '$answerHistoriesCountText / $clearsCountText';
      } else if (answerHistoriesCountText.isNotEmpty) {
        subtitleText = answerHistoriesCountText;
      } else {
        subtitleText = clearsCountText;
      }

      if (subtitleText.isEmpty) return null;

      return Text(
        subtitleText,
        style: TextStyle(color: Colors.black.withValues(alpha: 0.6)),
      );
    }

    Widget? examInfo() {
      if (!drill.examMode) return null;

      final List<Widget> children = [];
      final TextStyle metaTextStyle =
          TextStyle(color: Colors.black.withValues(alpha: 0.7), fontSize: 13);

      if (drill.examQuestionsCount != null) {
        children.add(
          Text(
            '${t.drills.exam_question_count}: ${t.drills.exam_question_count_details(count: drill.examQuestionsCount!, total: drill.quizzesCount)}',
            style: metaTextStyle,
          ),
        );
      }

      if (examAccessStatus != null) {
        final String statusLabel = switch (examAccessStatus) {
          _ExamAccessStatus.notStarted => t.drills.not_started,
          _ExamAccessStatus.ongoing => t.drills.access_status.ongoing,
          _ExamAccessStatus.expired => t.drills.access_status.unavailable,
        };

        children.add(
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 4,
            children: [
              Text('${t.drills.access_status_label}:', style: metaTextStyle),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _statusColor(examAccessStatus),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  statusLabel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );

        final String examPeriodText = _buildExamPeriodText();
        if (examPeriodText.isNotEmpty) {
          children.add(
            Text(
              '${t.drills.access_period}: $examPeriodText',
              style: metaTextStyle,
            ),
          );
        }
      }

      if (children.isEmpty) return null;

      return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children
              .expand((child) => [child, const SizedBox(height: 4)])
              .toList()
            ..removeLast(),
        ),
      );
    }

    // カードデザインの参考： https://material.io/components/cards/flutter
    return Card(
      margin: const EdgeInsets.only(bottom: 24),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        splashColor: Colors.green.withAlpha(30),
        onTap: () {
          moveToDrillPage(drill);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Container(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(drill.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                    if (drill.examMode)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          t.drills.exam,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              subtitle: subtitle(),
            ),
            if (examInfo() != null) examInfo()!,
            DrillThumbnail(drill: drill, drillLap: drillLap),
            Padding(
              padding: const EdgeInsets.only(
                  right: 16.0, left: 16, top: 16, bottom: 32),
              child: Text(
                drill.introduction,
                style: TextStyle(color: Colors.black.withValues(alpha: 0.6)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _ExamAccessStatus? _buildExamAccessStatus() {
    if (!drill.examMode) return null;
    if (drill.accessStartsAt == null && drill.accessEndsAt == null) return null;

    final DateTime now = DateTime.now().toUtc().add(_tokyoOffset);
    final DateTime? startsAt = _toTokyoTime(drill.accessStartsAt);
    final DateTime? endsAt = _toTokyoTime(drill.accessEndsAt);

    if (startsAt != null && now.isBefore(startsAt)) {
      return _ExamAccessStatus.notStarted;
    }
    if (endsAt != null && now.isAfter(endsAt)) {
      return _ExamAccessStatus.expired;
    }
    return _ExamAccessStatus.ongoing;
  }

  String _buildExamPeriodText() {
    final DateTime? startsAt = _toTokyoTime(drill.accessStartsAt);
    final DateTime? endsAt = _toTokyoTime(drill.accessEndsAt);
    if (startsAt == null && endsAt == null) return '';

    if (startsAt != null && endsAt != null) {
      final String startText = DateFormat('yyyy/MM/dd HH:mm').format(startsAt);
      final String endText;
      if (_isSameDate(startsAt, endsAt)) {
        endText = DateFormat('HH:mm').format(endsAt);
      } else if (startsAt.year == endsAt.year) {
        endText = DateFormat('MM/dd HH:mm').format(endsAt);
      } else {
        endText = DateFormat('yyyy/MM/dd HH:mm').format(endsAt);
      }
      return '$startText ～ $endText';
    }

    if (startsAt != null) {
      final String startText = DateFormat('yyyy/MM/dd HH:mm').format(startsAt);
      return '${t.drills.access_starts_at}: $startText';
    }

    final String endText = DateFormat('yyyy/MM/dd HH:mm').format(endsAt!);
    return '${t.drills.access_ends_at}: $endText';
  }

  DateTime? _toTokyoTime(DateTime? dateTime) {
    if (dateTime == null) return null;
    if (dateTime.isUtc) return dateTime.add(_tokyoOffset);
    return dateTime;
  }

  bool _isSameDate(DateTime lhs, DateTime rhs) {
    return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day;
  }

  Color _statusColor(_ExamAccessStatus status) {
    switch (status) {
      case _ExamAccessStatus.notStarted:
        return Colors.grey;
      case _ExamAccessStatus.ongoing:
        return Colors.green;
      case _ExamAccessStatus.expired:
        return Colors.red;
    }
  }
}
