import 'package:booqs_mobile/components/quiz/item/pronunciation_form.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('QuizPronunciationFlow.stopActionForStatus', () {
    test('defers stop while recorder startup is still in progress', () {
      expect(
        QuizPronunciationFlow.stopActionForStatus(
          QuizPronunciationStatus.starting,
        ),
        QuizPronunciationStopAction.defer,
      );
    });

    test('submits when recorder is actively listening', () {
      expect(
        QuizPronunciationFlow.stopActionForStatus(
          QuizPronunciationStatus.listening,
        ),
        QuizPronunciationStopAction.submit,
      );
    });

    test('ignores stop requests outside active recording states', () {
      expect(
        QuizPronunciationFlow.stopActionForStatus(
          QuizPronunciationStatus.pressing,
        ),
        QuizPronunciationStopAction.ignore,
      );
      expect(
        QuizPronunciationFlow.stopActionForStatus(QuizPronunciationStatus.idle),
        QuizPronunciationStopAction.ignore,
      );
      expect(
        QuizPronunciationFlow.stopActionForStatus(
          QuizPronunciationStatus.submitting,
        ),
        QuizPronunciationStopAction.ignore,
      );
      expect(
        QuizPronunciationFlow.stopActionForStatus(
          QuizPronunciationStatus.completed,
        ),
        QuizPronunciationStopAction.ignore,
      );
    });
  });
}
