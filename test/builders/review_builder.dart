import 'package:booqs_mobile/models/review.dart';

class ReviewBuilder {
  static Review build({
    int? id,
    int? userId,
    int? quizId,
    String? scheduledDate,
    int? intervalSetting,
    bool? reviewed,
    int? spacing,
  }) {
    return Review(
      id: id ?? 1,
      userId: userId ?? 1,
      quizId: quizId ?? 1,
      scheduledDate: scheduledDate ?? '2024-01-01',
      intervalSetting: intervalSetting ?? 1,
      reviewed: reviewed ?? false,
      spacing: spacing,
    );
  }
}