import 'package:booqs_mobile/i18n/translations_ja.g.dart';
import 'package:booqs_mobile/utils/pronunciation_error_type_localizer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('localizePronunciationErrorTypes', () {
    final translations = TranslationsJa();

    test('localizes known Azure error types for Japanese users', () {
      expect(
        localizePronunciationErrorTypes(
          'Mispronunciation, Insertion',
          translations,
        ),
        '発音誤り, 余分な発音',
      );
    });

    test('deduplicates localized values and keeps unknown types', () {
      expect(
        localizePronunciationErrorTypes(
          ['Insertion', 'Insertion', 'CustomError'],
          translations,
        ),
        '余分な発音, CustomError',
      );
    });
  });
}
