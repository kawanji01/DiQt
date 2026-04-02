import 'package:booqs_mobile/components/drill/list_item.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await LocaleSettings.setLocale(AppLocale.ja);
  });

  group('DrillListItem', () {
    testWidgets('shows exam question count for exam drills',
        (WidgetTester tester) async {
      final Drill drill = Drill.fromJson(
        _buildDrillJson(
          examMode: true,
          examQuestionsCount: 8,
        ),
      );

      await _pumpDrillListItem(tester, drill);

      expect(find.text('出題数: 8問（全20問中）'), findsOneWidget);
    });

    testWidgets('shows not started status and access period',
        (WidgetTester tester) async {
      final DateTime now = DateTime.now().toUtc();
      final DateTime startsAt = now.add(const Duration(days: 1));
      final DateTime endsAt = now.add(const Duration(days: 2, hours: 2));
      final Drill drill = Drill.fromJson(
        _buildDrillJson(
          examMode: true,
          accessStartsAt: startsAt,
          accessEndsAt: endsAt,
        ),
      );

      await _pumpDrillListItem(tester, drill);

      expect(find.text('未開始'), findsOneWidget);
      expect(find.text('実施状態:'), findsOneWidget);
      expect(
        find.text('実施期間: ${_buildExpectedPeriodText(startsAt, endsAt)}'),
        findsOneWidget,
      );
    });

    testWidgets('shows ongoing status for active exam drills',
        (WidgetTester tester) async {
      final DateTime now = DateTime.now().toUtc();
      final DateTime startsAt = now.subtract(const Duration(hours: 2));
      final DateTime endsAt = now.add(const Duration(hours: 2));
      final Drill drill = Drill.fromJson(
        _buildDrillJson(
          examMode: true,
          accessStartsAt: startsAt,
          accessEndsAt: endsAt,
        ),
      );

      await _pumpDrillListItem(tester, drill);

      expect(find.text('実施中'), findsOneWidget);
      expect(
        find.text('実施期間: ${_buildExpectedPeriodText(startsAt, endsAt)}'),
        findsOneWidget,
      );
    });

    testWidgets('shows expired status for ended exam drills',
        (WidgetTester tester) async {
      final DateTime now = DateTime.now().toUtc();
      final DateTime startsAt = now.subtract(const Duration(days: 3));
      final DateTime endsAt = now.subtract(const Duration(hours: 1));
      final Drill drill = Drill.fromJson(
        _buildDrillJson(
          examMode: true,
          accessStartsAt: startsAt,
          accessEndsAt: endsAt,
        ),
      );

      await _pumpDrillListItem(tester, drill);

      expect(find.text('アクセス不可'), findsOneWidget);
      expect(
        find.text('実施期間: ${_buildExpectedPeriodText(startsAt, endsAt)}'),
        findsOneWidget,
      );
    });

    testWidgets('hides status and period for unlimited exam drills',
        (WidgetTester tester) async {
      final Drill drill = Drill.fromJson(
        _buildDrillJson(
          examMode: true,
          examQuestionsCount: 5,
        ),
      );

      await _pumpDrillListItem(tester, drill);

      expect(find.text('出題数: 5問（全20問中）'), findsOneWidget);
      expect(find.text('実施状態:'), findsNothing);
      expect(find.textContaining('実施期間:'), findsNothing);
    });
  });
}

Future<void> _pumpDrillListItem(WidgetTester tester, Drill drill) async {
  await tester.pumpWidget(
    ProviderScope(
      child: TranslationProvider(
        child: MaterialApp(
          home: Scaffold(
            body: DrillListItem(drill: drill),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
}

Map<String, dynamic> _buildDrillJson({
  bool examMode = false,
  int? examQuestionsCount,
  DateTime? accessStartsAt,
  DateTime? accessEndsAt,
}) {
  final DateTime now = DateTime.utc(2026, 4, 2, 1, 0);
  return {
    'id': 1,
    'applied_dictionary_id': 1,
    'user_id': 1,
    'chapter_id': 1,
    'dictionary_id': null,
    'sentence_dictionary_id': null,
    'title': 'Sample Drill',
    'lang_number_of_title': 0,
    'introduction': 'Introduction',
    'reference_url': 'https://example.com',
    'thumbnail_url': 'https://example.com/thumb.png',
    'public_uid': 'drill-1',
    'strict_solving_mode': false,
    'exam_mode': examMode,
    'exam_questions_count': examQuestionsCount,
    'access_starts_at': accessStartsAt?.toIso8601String(),
    'access_ends_at': accessEndsAt?.toIso8601String(),
    'archived_at': null,
    'created_at': now.toIso8601String(),
    'updated_at': now.toIso8601String(),
    'answer_histories_count': 0,
    'quizzes_count': 20,
    'drill_lap': null,
    'chapter': null,
    'dictionary': null,
  };
}

String _buildExpectedPeriodText(DateTime? startsAt, DateTime? endsAt) {
  final DateTime? tokyoStartsAt = _toTokyoTime(startsAt);
  final DateTime? tokyoEndsAt = _toTokyoTime(endsAt);
  if (tokyoStartsAt == null && tokyoEndsAt == null) return '';

  if (tokyoStartsAt != null && tokyoEndsAt != null) {
    final String startText =
        DateFormat('yyyy/MM/dd HH:mm').format(tokyoStartsAt);
    final String endText;
    if (_isSameDate(tokyoStartsAt, tokyoEndsAt)) {
      endText = DateFormat('HH:mm').format(tokyoEndsAt);
    } else if (tokyoStartsAt.year == tokyoEndsAt.year) {
      endText = DateFormat('MM/dd HH:mm').format(tokyoEndsAt);
    } else {
      endText = DateFormat('yyyy/MM/dd HH:mm').format(tokyoEndsAt);
    }
    return '$startText ～ $endText';
  }

  if (tokyoStartsAt != null) {
    return '開始日時: ${DateFormat('yyyy/MM/dd HH:mm').format(tokyoStartsAt)}';
  }

  return '終了日時: ${DateFormat('yyyy/MM/dd HH:mm').format(tokyoEndsAt!)}';
}

DateTime? _toTokyoTime(DateTime? dateTime) {
  if (dateTime == null) return null;
  if (dateTime.isUtc) return dateTime.add(const Duration(hours: 9));
  return dateTime;
}

bool _isSameDate(DateTime lhs, DateTime rhs) {
  return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day;
}
