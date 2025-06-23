import 'package:flutter_test/flutter_test.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import '../builders/dictionary_builder.dart';

void main() {
  group('Dictionary', () {
    group('constructor', () {
      test('should create instance with required values', () {
        final now = DateTime.now();
        final dictionary = Dictionary(
          id: 1,
          title: 'English-Japanese Dictionary',
          publicUid: 'en-ja-001',
          langNumberOfEntry: 0,
          langNumberOfMeaning: 1,
          wordsCount: 1000,
          sentencesCount: 500,
          wordRequestsCount: 20,
          sentenceRequestsCount: 10,
          quizRequestsCount: 5,
          acceptedWordRequestsCount: 15,
          pendingWordRequestsCount: 3,
          acceptedSentenceRequestsCount: 7,
          pendingSentenceRequestsCount: 2,
          acceptedQuizRequestsCount: 4,
          pendingQuizRequestsCount: 1,
          createdAt: now,
          updatedAt: now,
          sentenceRequired: true,
          ipaRequired: false,
          posTagRequired: true,
        );
        
        expect(dictionary.id, 1);
        expect(dictionary.title, 'English-Japanese Dictionary');
        expect(dictionary.langNumberOfEntry, 0);
        expect(dictionary.langNumberOfMeaning, 1);
        expect(dictionary.sentenceRequired, true);
        expect(dictionary.ipaRequired, false);
        expect(dictionary.posTagRequired, true);
      });
    });

    group('equality and hashCode', () {
      test('should be equal when ids are the same', () {
        final dict1 = DictionaryBuilder.build(id: 1, title: 'Dict 1');
        final dict2 = DictionaryBuilder.build(id: 1, title: 'Dict 2');
        
        expect(dict1, equals(dict2));
        expect(dict1.hashCode, equals(dict2.hashCode));
      });

      test('should not be equal when ids are different', () {
        final dict1 = DictionaryBuilder.build(id: 1);
        final dict2 = DictionaryBuilder.build(id: 2);
        
        expect(dict1, isNot(equals(dict2)));
        expect(dict1.hashCode, isNot(equals(dict2.hashCode)));
      });

      test('should be identical to itself', () {
        final dict = DictionaryBuilder.build(id: 1);
        
        expect(dict, equals(dict));
        expect(identical(dict, dict), true);
      });
    });

    group('rejected count calculations', () {
      test('rejectedWordRequestsCount should calculate correctly', () {
        final dictionary = DictionaryBuilder.build(
          wordRequestsCount: 20,
          acceptedWordRequestsCount: 12,
          pendingWordRequestsCount: 5,
        );
        
        expect(dictionary.rejectedWordRequestsCount(), 3);
      });

      test('rejectedWordRequestsCount should return 0 when no rejected requests', () {
        final dictionary = DictionaryBuilder.build(
          wordRequestsCount: 10,
          acceptedWordRequestsCount: 7,
          pendingWordRequestsCount: 3,
        );
        
        expect(dictionary.rejectedWordRequestsCount(), 0);
      });

      test('rejectedSentenceRequestsCount should calculate correctly', () {
        final dictionary = DictionaryBuilder.build(
          sentenceRequestsCount: 15,
          acceptedSentenceRequestsCount: 8,
          pendingSentenceRequestsCount: 4,
        );
        
        expect(dictionary.rejectedSentenceRequestsCount(), 3);
      });

      test('rejectedQuizRequestsCount should calculate correctly', () {
        final dictionary = DictionaryBuilder.build(
          quizRequestsCount: 12,
          acceptedQuizRequestsCount: 7,
          pendingQuizRequestsCount: 2,
        );
        
        expect(dictionary.rejectedQuizRequestsCount(), 3);
      });

      test('should handle edge case with zero counts', () {
        final dictionary = DictionaryBuilder.build(
          wordRequestsCount: 0,
          acceptedWordRequestsCount: 0,
          pendingWordRequestsCount: 0,
        );
        
        expect(dictionary.rejectedWordRequestsCount(), 0);
      });

      test('should handle negative result (data inconsistency)', () {
        final dictionary = DictionaryBuilder.build(
          wordRequestsCount: 5,
          acceptedWordRequestsCount: 4,
          pendingWordRequestsCount: 3,
        );
        
        expect(dictionary.rejectedWordRequestsCount(), -2);
      });
    });

    group('language methods', () {
      test('langCodeOfEntry should return correct language code', () {
        final dictionary = DictionaryBuilder.build(langNumberOfEntry: 21);
        
        expect(dictionary.langCodeOfEntry(), 'en');
      });

      test('langCodeOfMeaning should return correct language code', () {
        final dictionary = DictionaryBuilder.build(langNumberOfMeaning: 44);
        
        expect(dictionary.langCodeOfMeaning(), 'ja');
      });

      test('languageOfEntry should return correct language name', () {
        final dictionary = DictionaryBuilder.build(langNumberOfEntry: 21);
        
        expect(dictionary.languageOfEntry(), 'English');
      });

      test('languageOfMeaning should return correct language name', () {
        final dictionary = DictionaryBuilder.build(langNumberOfMeaning: 44);
        
        expect(dictionary.languageOfMeaning(), 'Japanese');
      });

      test('typeName should return combined language format', () {
        final dictionary = DictionaryBuilder.build(
          langNumberOfEntry: 21,
          langNumberOfMeaning: 44,
        );
        
        expect(dictionary.typeName(), 'English - Japanese');
      });
    });

    group('monolingual and bilingual checks', () {
      test('monolingual should return true when entry and meaning languages are same', () {
        final dictionary = DictionaryBuilder.build(
          langNumberOfEntry: 21,
          langNumberOfMeaning: 21,
        );
        
        expect(dictionary.monolingual(), true);
        expect(dictionary.bilingual(), false);
      });

      test('bilingual should return true when entry and meaning languages are different', () {
        final dictionary = DictionaryBuilder.build(
          langNumberOfEntry: 21,
          langNumberOfMeaning: 44,
        );
        
        expect(dictionary.bilingual(), true);
        expect(dictionary.monolingual(), false);
      });

      test('should handle different language combinations', () {
        final dictionary = DictionaryBuilder.build(
          langNumberOfEntry: 25,  // French
          langNumberOfMeaning: 29,  // German
        );
        
        expect(dictionary.bilingual(), true);
        expect(dictionary.monolingual(), false);
      });
    });

    group('fromJson', () {
      test('should create instance from JSON with all fields', () {
        final json = {
          'id': 1,
          'title': 'Test Dictionary',
          'introduction': 'Test intro',
          'guideline': 'Test guideline',
          'credit': 'Test credit',
          'license': 'MIT',
          'image': 'test.jpg',
          'thumbnail_url': 'thumb.jpg',
          'public_uid': 'test-123',
          'lang_number_of_entry': 0,
          'lang_number_of_meaning': 1,
          'words_count': 1000,
          'sentences_count': 500,
          'word_requests_count': 20,
          'sentence_requests_count': 10,
          'quiz_requests_count': 5,
          'accepted_word_requests_count': 15,
          'pending_word_requests_count': 3,
          'accepted_sentence_requests_count': 8,
          'pending_sentence_requests_count': 1,
          'accepted_quiz_requests_count': 4,
          'pending_quiz_requests_count': 1,
          'sentence_required': true,
          'ipa_required': false,
          'pos_tag_required': true,
          'created_at': '2024-01-01T00:00:00Z',
          'updated_at': '2024-01-02T00:00:00Z',
        };

        final dictionary = Dictionary.fromJson(json);
        
        expect(dictionary.id, 1);
        expect(dictionary.title, 'Test Dictionary');
        expect(dictionary.introduction, 'Test intro');
        expect(dictionary.sentenceRequired, true);
        expect(dictionary.ipaRequired, false);
        expect(dictionary.posTagRequired, true);
        expect(dictionary.createdAt, DateTime.parse('2024-01-01T00:00:00Z'));
        expect(dictionary.updatedAt, DateTime.parse('2024-01-02T00:00:00Z'));
      });

      test('should handle default values for boolean fields', () {
        final json = {
          'id': 1,
          'title': 'Test Dictionary',
          'public_uid': 'test-123',
          'lang_number_of_entry': 0,
          'lang_number_of_meaning': 1,
          'words_count': 100,
          'sentences_count': 50,
          'word_requests_count': 10,
          'sentence_requests_count': 5,
          'quiz_requests_count': 3,
          'accepted_word_requests_count': 5,
          'pending_word_requests_count': 2,
          'accepted_sentence_requests_count': 3,
          'pending_sentence_requests_count': 1,
          'accepted_quiz_requests_count': 2,
          'pending_quiz_requests_count': 1,
          'created_at': '2024-01-01T00:00:00Z',
          'updated_at': '2024-01-02T00:00:00Z',
          // Missing boolean fields should default to false
        };

        final dictionary = Dictionary.fromJson(json);
        
        expect(dictionary.sentenceRequired, false);
        expect(dictionary.ipaRequired, false);
        expect(dictionary.posTagRequired, false);
      });

      test('should handle null pos_tags array', () {
        final json = {
          'id': 1,
          'title': 'Test Dictionary',
          'public_uid': 'test-123',
          'lang_number_of_entry': 0,
          'lang_number_of_meaning': 1,
          'words_count': 100,
          'sentences_count': 50,
          'word_requests_count': 10,
          'sentence_requests_count': 5,
          'quiz_requests_count': 3,
          'accepted_word_requests_count': 5,
          'pending_word_requests_count': 2,
          'accepted_sentence_requests_count': 3,
          'pending_sentence_requests_count': 1,
          'accepted_quiz_requests_count': 2,
          'pending_quiz_requests_count': 1,
          'created_at': '2024-01-01T00:00:00Z',
          'updated_at': '2024-01-02T00:00:00Z',
          'pos_tags': null,
        };

        final dictionary = Dictionary.fromJson(json);
        
        expect(dictionary.posTags, isEmpty);
      });
    });

    group('toJson', () {
      test('should convert instance to JSON', () {
        final now = DateTime.now();
        final dictionary = DictionaryBuilder.build(
          id: 1,
          title: 'Test Dictionary',
          introduction: 'Test intro',
          sentenceRequired: true,
          createdAt: now,
          updatedAt: now,
        );

        final json = dictionary.toJson();
        
        expect(json['id'], 1);
        expect(json['title'], 'Test Dictionary');
        expect(json['introduction'], 'Test intro');
        expect(json['sentence_required'], true);
        expect(json['created_at'], now);
        expect(json['updated_at'], now);
      });
    });

    group('edge cases', () {
      test('should handle very large numbers', () {
        final dictionary = DictionaryBuilder.build(
          wordsCount: 999999999,
          wordRequestsCount: 1000000,
          acceptedWordRequestsCount: 500000,
          pendingWordRequestsCount: 300000,
        );
        
        expect(dictionary.wordsCount, 999999999);
        expect(dictionary.rejectedWordRequestsCount(), 200000);
      });

      test('should handle zero counts', () {
        final dictionary = DictionaryBuilder.build(
          wordsCount: 0,
          sentencesCount: 0,
          wordRequestsCount: 0,
          sentenceRequestsCount: 0,
          quizRequestsCount: 0,
          acceptedWordRequestsCount: 0,
          pendingWordRequestsCount: 0,
          acceptedSentenceRequestsCount: 0,
          pendingSentenceRequestsCount: 0,
          acceptedQuizRequestsCount: 0,
          pendingQuizRequestsCount: 0,
        );
        
        expect(dictionary.wordsCount, 0);
        expect(dictionary.sentencesCount, 0);
        expect(dictionary.rejectedWordRequestsCount(), 0);
        expect(dictionary.rejectedSentenceRequestsCount(), 0);
        expect(dictionary.rejectedQuizRequestsCount(), 0);
      });

      test('should handle special characters in text fields', () {
        final dictionary = DictionaryBuilder.build(
          title: 'Français-日本語 辞書',
          introduction: 'Introduction with émojis 😊',
          publicUid: 'fr-jp-special-chars-123',
        );
        
        expect(dictionary.title, 'Français-日本語 辞書');
        expect(dictionary.introduction, 'Introduction with émojis 😊');
        expect(dictionary.publicUid, 'fr-jp-special-chars-123');
      });
    });
  });
}