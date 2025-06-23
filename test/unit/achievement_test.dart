import 'package:flutter_test/flutter_test.dart';
import 'package:booqs_mobile/models/achievement.dart';
import '../builders/achievement_builder.dart';

void main() {
  group('Achievement', () {
    group('constructor', () {
      test('should create instance with required values', () {
        final now = DateTime.now();
        final achievement = Achievement(
          id: 1,
          orderNumber: 5,
          i18nKey: 'first_answer',
          name: '初回解答',
          introduction: '初めて問題に解答しました',
          praiseText: 'よくできました！',
          exp: 50,
          imageUrl: 'https://example.com/badge.png',
          lockedImageUrl: 'https://example.com/locked.png',
          tutorial: true,
          numberOfAnswers: true,
          daysAnswered: false,
          master: false,
          createdAt: now,
          updatedAt: now,
        );
        
        expect(achievement.id, 1);
        expect(achievement.orderNumber, 5);
        expect(achievement.i18nKey, 'first_answer');
        expect(achievement.name, '初回解答');
        expect(achievement.introduction, '初めて問題に解答しました');
        expect(achievement.praiseText, 'よくできました！');
        expect(achievement.exp, 50);
        expect(achievement.imageUrl, 'https://example.com/badge.png');
        expect(achievement.lockedImageUrl, 'https://example.com/locked.png');
        expect(achievement.tutorial, true);
        expect(achievement.numberOfAnswers, true);
        expect(achievement.daysAnswered, false);
        expect(achievement.master, false);
        expect(achievement.createdAt, now);
        expect(achievement.updatedAt, now);
      });

      test('should create instance with nullable fields as null', () {
        final now = DateTime.now();
        final achievement = Achievement(
          id: 1,
          orderNumber: 1,
          i18nKey: 'test',
          name: 'テスト',
          introduction: null,
          praiseText: null,
          exp: 100,
          imageUrl: 'https://example.com/test.png',
          lockedImageUrl: 'https://example.com/locked.png',
          tutorial: false,
          numberOfAnswers: false,
          daysAnswered: false,
          master: false,
          createdAt: now,
          updatedAt: now,
        );
        
        expect(achievement.introduction, null);
        expect(achievement.praiseText, null);
      });

      test('should create instance with different boolean combinations', () {
        final achievement = AchievementBuilder.build(
          tutorial: true,
          numberOfAnswers: true,
          daysAnswered: true,
          master: true,
        );
        
        expect(achievement.tutorial, true);
        expect(achievement.numberOfAnswers, true);
        expect(achievement.daysAnswered, true);
        expect(achievement.master, true);
      });
    });

    group('fromJson', () {
      test('should create instance from JSON with all fields', () {
        final json = {
          'id': 10,
          'order_number': 3,
          'i18n_key': 'daily_master',
          'name': '日次マスター',
          'introduction': '毎日学習を続けています',
          'praise_text': '継続は力なり！',
          'exp': 200,
          'cloudinary_image': 'https://example.com/daily.png',
          'cloudinary_image_locked': 'https://example.com/daily_locked.png',
          'tutorial': false,
          'number_of_answers': false,
          'days_answered': true,
          'master': false,
          'created_at': '2024-01-15T10:30:00Z',
          'updated_at': '2024-01-16T15:45:00Z',
        };

        final achievement = Achievement.fromJson(json);
        
        expect(achievement.id, 10);
        expect(achievement.orderNumber, 3);
        expect(achievement.i18nKey, 'daily_master');
        expect(achievement.name, '日次マスター');
        expect(achievement.introduction, '毎日学習を続けています');
        expect(achievement.praiseText, '継続は力なり！');
        expect(achievement.exp, 200);
        expect(achievement.imageUrl, 'https://example.com/daily.png');
        expect(achievement.lockedImageUrl, 'https://example.com/daily_locked.png');
        expect(achievement.tutorial, false);
        expect(achievement.numberOfAnswers, false);
        expect(achievement.daysAnswered, true);
        expect(achievement.master, false);
        expect(achievement.createdAt, DateTime.parse('2024-01-15T10:30:00Z'));
        expect(achievement.updatedAt, DateTime.parse('2024-01-16T15:45:00Z'));
      });

      test('should handle null and empty string values correctly', () {
        final json = {
          'id': 5,
          'order_number': 1,
          'i18n_key': null,
          'name': null,
          'introduction': null,
          'praise_text': null,
          'exp': 0,
          'cloudinary_image': null,
          'cloudinary_image_locked': null,
          'tutorial': false,
          'number_of_answers': false,
          'days_answered': false,
          'master': false,
          'created_at': '2024-01-01T00:00:00Z',
          'updated_at': '2024-01-01T00:00:00Z',
        };

        final achievement = Achievement.fromJson(json);
        
        expect(achievement.id, 5);
        expect(achievement.orderNumber, 1);
        expect(achievement.i18nKey, '');
        expect(achievement.name, '');
        expect(achievement.introduction, '');
        expect(achievement.praiseText, '');
        expect(achievement.exp, 0);
        expect(achievement.imageUrl, '');
        expect(achievement.lockedImageUrl, '');
        expect(achievement.tutorial, false);
        expect(achievement.numberOfAnswers, false);
        expect(achievement.daysAnswered, false);
        expect(achievement.master, false);
      });

      test('should handle maximum and boundary values', () {
        final json = {
          'id': 2147483647,
          'order_number': 999,
          'i18n_key': 'long_achievement_key_with_many_characters',
          'name': '非常に長い実績名を持つ特別な実績',
          'introduction': '詳細な説明文が含まれた実績の紹介文',
          'praise_text': 'とても素晴らしい成果です！おめでとうございます！',
          'exp': 9999,
          'cloudinary_image': 'https://very-long-url.example.com/path/to/achievement/image.png',
          'cloudinary_image_locked': 'https://very-long-url.example.com/path/to/locked/image.png',
          'tutorial': true,
          'number_of_answers': true,
          'days_answered': true,
          'master': true,
          'created_at': '2024-12-31T23:59:59.999Z',
          'updated_at': '2024-12-31T23:59:59.999Z',
        };

        final achievement = Achievement.fromJson(json);
        
        expect(achievement.id, 2147483647);
        expect(achievement.orderNumber, 999);
        expect(achievement.exp, 9999);
        expect(achievement.tutorial, true);
        expect(achievement.numberOfAnswers, true);
        expect(achievement.daysAnswered, true);
        expect(achievement.master, true);
      });

      test('should handle all boolean combinations', () {
        final testCases = [
          {'tutorial': false, 'number_of_answers': false, 'days_answered': false, 'master': false},
          {'tutorial': true, 'number_of_answers': false, 'days_answered': false, 'master': false},
          {'tutorial': false, 'number_of_answers': true, 'days_answered': false, 'master': false},
          {'tutorial': false, 'number_of_answers': false, 'days_answered': true, 'master': false},
          {'tutorial': false, 'number_of_answers': false, 'days_answered': false, 'master': true},
          {'tutorial': true, 'number_of_answers': true, 'days_answered': true, 'master': true},
        ];

        for (int i = 0; i < testCases.length; i++) {
          final testCase = testCases[i];
          final json = {
            'id': i + 1,
            'order_number': i + 1,
            'i18n_key': 'test_$i',
            'name': 'テスト$i',
            'introduction': 'テスト実績$i',
            'praise_text': 'おめでとう$i',
            'exp': (i + 1) * 10,
            'cloudinary_image': 'https://example.com/test_$i.png',
            'cloudinary_image_locked': 'https://example.com/locked_$i.png',
            'tutorial': testCase['tutorial'],
            'number_of_answers': testCase['number_of_answers'],
            'days_answered': testCase['days_answered'],
            'master': testCase['master'],
            'created_at': '2024-01-01T00:00:00Z',
            'updated_at': '2024-01-01T00:00:00Z',
          };

          final achievement = Achievement.fromJson(json);
          
          expect(achievement.tutorial, testCase['tutorial']);
          expect(achievement.numberOfAnswers, testCase['number_of_answers']);
          expect(achievement.daysAnswered, testCase['days_answered']);
          expect(achievement.master, testCase['master']);
        }
      });
    });

    group('toJson', () {
      test('should convert instance to JSON', () {
        final now = DateTime.parse('2024-06-15T12:00:00Z');
        final achievement = AchievementBuilder.build(
          id: 20,
          orderNumber: 7,
          i18nKey: 'weekly_champion',
          name: '週間チャンピオン',
          introduction: '1週間連続で学習しました',
          praiseText: '素晴らしい継続力です！',
          exp: 150,
          imageUrl: 'https://example.com/weekly.png',
          lockedImageUrl: 'https://example.com/weekly_locked.png',
          tutorial: false,
          numberOfAnswers: false,
          daysAnswered: true,
          master: false,
          createdAt: now,
          updatedAt: now,
        );

        final json = achievement.toJson();
        
        expect(json['id'], 20);
        expect(json['order_number'], 7);
        expect(json['i18n_key'], 'weekly_champion');
        expect(json['name'], '週間チャンピオン');
        expect(json['introduction'], '1週間連続で学習しました');
        expect(json['praise_text'], '素晴らしい継続力です！');
        expect(json['exp'], 150);
        expect(json['cloudinary_image'], 'https://example.com/weekly.png');
        expect(json['cloudinary_image_locked'], 'https://example.com/weekly_locked.png');
        expect(json['tutorial'], false);
        expect(json['number_of_answers'], false);
        expect(json['days_answered'], true);
        expect(json['master'], false);
        expect(json['created_at'], now);
        expect(json['updated_at'], now);
      });

      test('should handle null values correctly', () {
        final now = DateTime.now();
        final achievement = Achievement(
          id: 1,
          orderNumber: 1,
          i18nKey: 'test',
          name: 'テスト',
          introduction: null,
          praiseText: null,
          exp: 100,
          imageUrl: 'https://example.com/test.png',
          lockedImageUrl: 'https://example.com/locked.png',
          tutorial: false,
          numberOfAnswers: false,
          daysAnswered: false,
          master: false,
          createdAt: now,
          updatedAt: now,
        );

        final json = achievement.toJson();
        
        expect(json['introduction'], null);
        expect(json['praise_text'], null);
      });

      test('should include all boolean combinations correctly', () {
        final achievement = AchievementBuilder.build(
          tutorial: true,
          numberOfAnswers: true,
          daysAnswered: false,
          master: true,
        );

        final json = achievement.toJson();
        
        expect(json['tutorial'], true);
        expect(json['number_of_answers'], true);
        expect(json['days_answered'], false);
        expect(json['master'], true);
      });
    });

    group('JSON serialization round-trip', () {
      test('should maintain data integrity through fromJson -> toJson', () {
        final originalJson = {
          'id': 50,
          'order_number': 25,
          'i18n_key': 'master_achiever',
          'name': 'マスター実績者',
          'introduction': 'すべての条件を満たした実績',
          'praise_text': '完璧な成果です！',
          'exp': 500,
          'cloudinary_image': 'https://example.com/master.png',
          'cloudinary_image_locked': 'https://example.com/master_locked.png',
          'tutorial': true,
          'number_of_answers': true,
          'days_answered': true,
          'master': true,
          'created_at': '2024-03-15T08:30:00Z',
          'updated_at': '2024-03-16T10:45:00Z',
        };

        final achievement = Achievement.fromJson(originalJson);
        final serializedJson = achievement.toJson();
        
        expect(serializedJson['id'], originalJson['id']);
        expect(serializedJson['order_number'], originalJson['order_number']);
        expect(serializedJson['i18n_key'], originalJson['i18n_key']);
        expect(serializedJson['name'], originalJson['name']);
        expect(serializedJson['introduction'], originalJson['introduction']);
        expect(serializedJson['praise_text'], originalJson['praise_text']);
        expect(serializedJson['exp'], originalJson['exp']);
        expect(serializedJson['cloudinary_image'], originalJson['cloudinary_image']);
        expect(serializedJson['cloudinary_image_locked'], originalJson['cloudinary_image_locked']);
        expect(serializedJson['tutorial'], originalJson['tutorial']);
        expect(serializedJson['number_of_answers'], originalJson['number_of_answers']);
        expect(serializedJson['days_answered'], originalJson['days_answered']);
        expect(serializedJson['master'], originalJson['master']);
        expect(serializedJson['created_at'], DateTime.parse(originalJson['created_at'] as String));
        expect(serializedJson['updated_at'], DateTime.parse(originalJson['updated_at'] as String));
      });

      test('should handle round-trip with null values', () {
        final originalJson = {
          'id': 99,
          'order_number': 1,
          'i18n_key': null,
          'name': null,
          'introduction': null,
          'praise_text': null,
          'exp': 0,
          'cloudinary_image': null,
          'cloudinary_image_locked': null,
          'tutorial': false,
          'number_of_answers': false,
          'days_answered': false,
          'master': false,
          'created_at': '2024-01-01T00:00:00Z',
          'updated_at': '2024-01-01T00:00:00Z',
        };

        final achievement = Achievement.fromJson(originalJson);
        final serializedJson = achievement.toJson();
        
        // null値は空文字として変換される
        expect(serializedJson['i18n_key'], '');
        expect(serializedJson['name'], '');
        expect(serializedJson['introduction'], '');
        expect(serializedJson['praise_text'], '');
        expect(serializedJson['cloudinary_image'], '');
        expect(serializedJson['cloudinary_image_locked'], '');
      });
    });

    group('edge cases', () {
      test('should handle zero and minimum values', () {
        final achievement = AchievementBuilder.build(
          id: 0,
          orderNumber: 0,
          exp: 0,
        );
        
        expect(achievement.id, 0);
        expect(achievement.orderNumber, 0);
        expect(achievement.exp, 0);
      });

      test('should handle very large values', () {
        final achievement = AchievementBuilder.build(
          id: 2147483647,
          orderNumber: 999999,
          exp: 999999,
        );
        
        expect(achievement.id, 2147483647);
        expect(achievement.orderNumber, 999999);
        expect(achievement.exp, 999999);
      });

      test('should handle empty strings', () {
        final achievement = AchievementBuilder.build(
          i18nKey: '',
          name: '',
          introduction: '',
          praiseText: '',
          imageUrl: '',
          lockedImageUrl: '',
        );
        
        expect(achievement.i18nKey, '');
        expect(achievement.name, '');
        expect(achievement.introduction, '');
        expect(achievement.praiseText, '');
        expect(achievement.imageUrl, '');
        expect(achievement.lockedImageUrl, '');
      });

      test('should handle achievement type combinations', () {
        // チュートリアル系実績
        final tutorialAchievement = AchievementBuilder.build(
          tutorial: true,
          numberOfAnswers: false,
          daysAnswered: false,
          master: false,
        );
        
        // 解答数系実績
        final answersAchievement = AchievementBuilder.build(
          tutorial: false,
          numberOfAnswers: true,
          daysAnswered: false,
          master: false,
        );
        
        // 継続日数系実績
        final daysAchievement = AchievementBuilder.build(
          tutorial: false,
          numberOfAnswers: false,
          daysAnswered: true,
          master: false,
        );
        
        // マスター系実績
        final masterAchievement = AchievementBuilder.build(
          tutorial: false,
          numberOfAnswers: false,
          daysAnswered: false,
          master: true,
        );
        
        expect(tutorialAchievement.tutorial, true);
        expect(answersAchievement.numberOfAnswers, true);
        expect(daysAchievement.daysAnswered, true);
        expect(masterAchievement.master, true);
      });

      test('should handle special character strings', () {
        final achievement = AchievementBuilder.build(
          i18nKey: 'key_with_underscore_123',
          name: '特殊文字を含む実績名！？',
          introduction: '絵文字も含む説明📚✨',
          praiseText: '日本語、English、数字123、記号！',
        );
        
        expect(achievement.i18nKey, 'key_with_underscore_123');
        expect(achievement.name, '特殊文字を含む実績名！？');
        expect(achievement.introduction, '絵文字も含む説明📚✨');
        expect(achievement.praiseText, '日本語、English、数字123、記号！');
      });
    });
  });
}