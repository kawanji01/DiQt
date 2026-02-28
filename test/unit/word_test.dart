import 'package:flutter_test/flutter_test.dart';
import 'package:booqs_mobile/models/word.dart';
import '../builders/word_builder.dart';

void main() {
  group('Word', () {
    group('constructor', () {
      test('should create instance with required values', () {
        final word = Word(
          id: 1,
          dictionaryId: 1,
          entry: 'test',
          langNumberOfEntry: 0,
          meaning: 'テスト',
          langNumberOfMeaning: 1,
          wordRequestsCount: 0,
          acceptedWordRequestsCount: 0,
          pendingWordRequestsCount: 0,
        );

        expect(word.id, 1);
        expect(word.dictionaryId, 1);
        expect(word.entry, 'test');
        expect(word.meaning, 'テスト');
        expect(word.explanation, '');
        expect(word.phrase, isFalse);
        expect(word.wordRequestsCount, 0);
      });

      test('should create instance with optional values', () {
        final word = Word(
          id: 1,
          dictionaryId: 1,
          entry: 'example',
          langNumberOfEntry: 0,
          meaning: '例',
          langNumberOfMeaning: 1,
          wordRequestsCount: 10,
          acceptedWordRequestsCount: 5,
          pendingWordRequestsCount: 2,
          explanation: 'Test explanation',
          pos: 'noun',
          ipa: '/ɪɡˈzæmpəl/',
          reading: 'イグザンプル',
        );

        expect(word.explanation, 'Test explanation');
        expect(word.pos, 'noun');
        expect(word.ipa, '/ɪɡˈzæmpəl/');
        expect(word.reading, 'イグザンプル');
      });
    });

    group('rejectedWordRequestsCount', () {
      test('should calculate correctly when all counts are positive', () {
        final word = WordBuilder.build(
          wordRequestsCount: 10,
          acceptedWordRequestsCount: 5,
          pendingWordRequestsCount: 2,
        );

        expect(word.rejectedWordRequestsCount(), 3);
      });

      test('should return 0 when total equals accepted plus pending', () {
        final word = WordBuilder.build(
          wordRequestsCount: 7,
          acceptedWordRequestsCount: 5,
          pendingWordRequestsCount: 2,
        );

        expect(word.rejectedWordRequestsCount(), 0);
      });

      test('should handle edge case with zero counts', () {
        final word = WordBuilder.build(
          wordRequestsCount: 0,
          acceptedWordRequestsCount: 0,
          pendingWordRequestsCount: 0,
        );

        expect(word.rejectedWordRequestsCount(), 0);
      });

      test('should handle case with only rejected requests', () {
        final word = WordBuilder.build(
          wordRequestsCount: 5,
          acceptedWordRequestsCount: 0,
          pendingWordRequestsCount: 0,
        );

        expect(word.rejectedWordRequestsCount(), 5);
      });

      test('should handle large numbers', () {
        final word = WordBuilder.build(
          wordRequestsCount: 1000,
          acceptedWordRequestsCount: 300,
          pendingWordRequestsCount: 200,
        );

        expect(word.rejectedWordRequestsCount(), 500);
      });
    });

    group('fromJson', () {
      test('should create instance from JSON with required fields only', () {
        final json = {
          'id': 1,
          'dictionary_id': 2,
          'entry': 'hello',
          'lang_number_of_entry': 0,
          'meaning': 'こんにちは',
          'lang_number_of_meaning': 1,
          'word_requests_count': 5,
          'accepted_word_requests_count': 3,
          'pending_word_requests_count': 1,
          'phrase': true,
        };

        final word = Word.fromJson(json);

        expect(word.id, 1);
        expect(word.dictionaryId, 2);
        expect(word.entry, 'hello');
        expect(word.meaning, 'こんにちは');
        expect(word.wordRequestsCount, 5);
        expect(word.acceptedWordRequestsCount, 3);
        expect(word.pendingWordRequestsCount, 1);
        expect(word.phrase, isTrue);
      });

      test('should default phrase to false when omitted', () {
        final json = {
          'id': 1,
          'dictionary_id': 2,
          'entry': 'hello',
          'lang_number_of_entry': 0,
          'meaning': 'こんにちは',
          'lang_number_of_meaning': 1,
          'word_requests_count': 5,
          'accepted_word_requests_count': 3,
          'pending_word_requests_count': 1,
        };

        final word = Word.fromJson(json);

        expect(word.phrase, isFalse);
      });

      test('should create instance from JSON with all optional fields', () {
        final json = {
          'id': 1,
          'dictionary_id': 2,
          'sentence_id': 3,
          'pos_tag_id': 4,
          'entry': 'beautiful',
          'lang_number_of_entry': 0,
          'entry_ssml': '<speak>beautiful</speak>',
          'entry_audio_url': 'https://example.com/audio.mp3',
          'meaning': '美しい',
          'ja_meaning': '美しい',
          'en_meaning': 'beautiful',
          'lang_number_of_meaning': 1,
          'explanation': 'An adjective describing beauty',
          'meaning_image_url': 'https://example.com/image.jpg',
          'pos': 'adjective',
          'ipa': '/ˈbjuːtɪfʊl/',
          'reading': 'ビューティフル',
          'etymologies': 'Middle English',
          'synonyms': 'pretty, lovely',
          'antonyms': 'ugly, hideous',
          'related': 'beauty, beautifully',
          'senses_json': '["sense1", "sense2"]',
          'senses_tags': ['tag1', 'tag2'],
          'forms_list': ['beautiful', 'more beautiful'],
          'word_requests_count': 10,
          'accepted_word_requests_count': 6,
          'pending_word_requests_count': 2,
        };

        final word = Word.fromJson(json);

        expect(word.sentenceId, 3);
        expect(word.posTagId, 4);
        expect(word.entrySsml, '<speak>beautiful</speak>');
        expect(word.entryAudioUrl, 'https://example.com/audio.mp3');
        expect(word.explanation, 'An adjective describing beauty');
        expect(word.pos, 'adjective');
        expect(word.ipa, '/ˈbjuːtɪfʊl/');
        expect(word.reading, 'ビューティフル');
        expect(word.synonyms, 'pretty, lovely');
        expect(word.antonyms, 'ugly, hideous');
      });

      test('should handle null optional fields correctly', () {
        final json = {
          'id': 1,
          'dictionary_id': 2,
          'entry': 'test',
          'lang_number_of_entry': 0,
          'meaning': 'テスト',
          'lang_number_of_meaning': 1,
          'word_requests_count': 0,
          'accepted_word_requests_count': 0,
          'pending_word_requests_count': 0,
          'sentence_id': null,
          'pos_tag_id': null,
          'explanation': null,
          'pos': null,
          'ipa': null,
        };

        final word = Word.fromJson(json);

        expect(word.sentenceId, isNull);
        expect(word.posTagId, isNull);
        expect(word.explanation, isNull);
        expect(word.pos, isNull);
        expect(word.ipa, isNull);
      });

      test('should handle empty arrays for related objects', () {
        final json = {
          'id': 1,
          'dictionary_id': 2,
          'entry': 'test',
          'lang_number_of_entry': 0,
          'meaning': 'テスト',
          'lang_number_of_meaning': 1,
          'word_requests_count': 0,
          'accepted_word_requests_count': 0,
          'pending_word_requests_count': 0,
          'word_tags': null,
          'senses': null,
          'grammatical_tags': null,
        };

        final word = Word.fromJson(json);

        expect(word.wordTags, isEmpty);
        expect(word.senses, isEmpty);
        expect(word.grammaticalTags, isEmpty);
      });
    });

    group('toJson', () {
      test('should convert instance to JSON', () {
        final word = WordBuilder.build(
          id: 1,
          dictionaryId: 2,
          entry: 'example',
          meaning: '例',
          wordRequestsCount: 5,
          acceptedWordRequestsCount: 3,
          pendingWordRequestsCount: 1,
          explanation: 'Test explanation',
          pos: 'noun',
        );

        final json = word.toJson();

        expect(json['id'], 1);
        expect(json['dictionary_id'], 2);
        expect(json['entry'], 'example');
        expect(json['meaning'], '例');
        expect(json['word_requests_count'], 5);
        expect(json['accepted_word_requests_count'], 3);
        expect(json['pending_word_requests_count'], 1);
        expect(json['explanation'], 'Test explanation');
        expect(json['pos'], 'noun');
        expect(json['phrase'], false);
      });

      test('should handle null values in toJson', () {
        final word = WordBuilder.build(
          sentenceId: null,
          posTagId: null,
          explanation: null,
          pos: null,
        );

        final json = word.toJson();

        expect(json['sentence_id'], isNull);
        expect(json['pos_tag_id'], isNull);
        expect(json['explanation'], ''); // Default value
        expect(json['pos'], isNull);
      });
    });

    group('JSON serialization round-trip', () {
      test('should maintain data integrity through fromJson -> toJson', () {
        final originalJson = {
          'id': 1,
          'dictionary_id': 2,
          'entry': 'test',
          'lang_number_of_entry': 0,
          'meaning': 'テスト',
          'lang_number_of_meaning': 1,
          'explanation': 'Test explanation',
          'pos': 'noun',
          'ipa': '/test/',
          'word_requests_count': 10,
          'accepted_word_requests_count': 5,
          'pending_word_requests_count': 2,
        };

        final word = Word.fromJson(originalJson);
        final serializedJson = word.toJson();

        expect(serializedJson['id'], originalJson['id']);
        expect(serializedJson['dictionary_id'], originalJson['dictionary_id']);
        expect(serializedJson['entry'], originalJson['entry']);
        expect(serializedJson['meaning'], originalJson['meaning']);
        expect(serializedJson['explanation'], originalJson['explanation']);
        expect(serializedJson['pos'], originalJson['pos']);
        expect(serializedJson['word_requests_count'],
            originalJson['word_requests_count']);
      });
    });

    group('edge cases', () {
      test('should handle negative rejected count calculation', () {
        // Edge case where accepted + pending > total (data inconsistency)
        final word = WordBuilder.build(
          wordRequestsCount: 5,
          acceptedWordRequestsCount: 4,
          pendingWordRequestsCount: 3,
        );

        expect(word.rejectedWordRequestsCount(), -2);
      });

      test('should handle very long strings', () {
        final longString = 'a' * 1000;
        final word = WordBuilder.build(
          entry: longString,
          meaning: longString,
          explanation: longString,
        );

        expect(word.entry, longString);
        expect(word.meaning, longString);
        expect(word.explanation, longString);
      });

      test('should handle special characters in strings', () {
        final word = WordBuilder.build(
          entry: 'café',
          meaning: '咖啡館',
          ipa: '/kæˈfeɪ/',
          reading: 'カフェ',
        );

        expect(word.entry, 'café');
        expect(word.meaning, '咖啡館');
        expect(word.ipa, '/kæˈfeɪ/');
        expect(word.reading, 'カフェ');
      });

      test('should handle empty strings', () {
        final word = WordBuilder.build(
          entry: '',
          meaning: '',
          explanation: '',
        );

        expect(word.entry, '');
        expect(word.meaning, '');
        expect(word.explanation, '');
      });
    });
  });
}
