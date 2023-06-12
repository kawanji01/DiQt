import 'package:booqs_mobile/i18n/translations.g.dart';

class ReviewHelper {
  static String intervalText(number) {
    switch (number) {
      case 0:
        return t.reviews.tomorrow;
      case 1:
        return t.reviews.after_3_days;
      case 2:
        return t.reviews.after_a_week;
      case 3:
        return t.reviews.after_2_week;
      case 4:
        return t.reviews.after_3_week;
      case 5:
        return t.reviews.after_a_month;
      case 6:
        return t.reviews.after_2_month;
      case 7:
        return t.reviews.after_3_month;
      case 8:
        return t.reviews.after_6_month;
      case 9:
        return t.reviews.after_a_year;
      default:
        return '';
    }
  }

  static String reviewButtonLabel(number) {
    return t.reviews.review_for(interval: ReviewHelper.intervalText(number));
  }
}
