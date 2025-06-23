import 'package:booqs_mobile/models/achievement.dart';

class AchievementBuilder {
  static Achievement build({
    int? id,
    int? orderNumber,
    String? i18nKey,
    String? name,
    String? introduction,
    String? praiseText,
    int? exp,
    String? imageUrl,
    String? lockedImageUrl,
    bool? tutorial,
    bool? numberOfAnswers,
    bool? daysAnswered,
    bool? master,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    final now = DateTime.now();
    return Achievement(
      id: id ?? 1,
      orderNumber: orderNumber ?? 1,
      i18nKey: i18nKey ?? 'test_achievement',
      name: name ?? 'テスト実績',
      introduction: introduction ?? 'テスト実績の説明',
      praiseText: praiseText ?? 'おめでとうございます！',
      exp: exp ?? 100,
      imageUrl: imageUrl ?? 'https://example.com/achievement.png',
      lockedImageUrl: lockedImageUrl ?? 'https://example.com/locked.png',
      tutorial: tutorial ?? false,
      numberOfAnswers: numberOfAnswers ?? false,
      daysAnswered: daysAnswered ?? false,
      master: master ?? false,
      createdAt: createdAt ?? now,
      updatedAt: updatedAt ?? now,
    );
  }
}