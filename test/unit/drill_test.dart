import 'package:booqs_mobile/models/drill.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Drill', () {
    group('fromJson', () {
      test('should parse exam settings fields', () {
        final DateTime startsAt = DateTime.utc(2026, 4, 3, 1, 0);
        final DateTime endsAt = DateTime.utc(2026, 4, 4, 1, 0);
        final Drill drill = Drill.fromJson(
          _buildDrillJson(
            examMode: true,
            examQuestionsCount: 8,
            accessStartsAt: startsAt,
            accessEndsAt: endsAt,
          ),
        );

        expect(drill.examMode, isTrue);
        expect(drill.examQuestionsCount, 8);
        expect(drill.accessStartsAt, startsAt);
        expect(drill.accessEndsAt, endsAt);
      });
    });
  });
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
