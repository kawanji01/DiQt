import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/helpers/review.dart';

class AnswerSettingHelper {
  //
  static String initialIntervalText(int number) {
    return ReviewHelper.intervalText(number);
  }

  //

  // 復習の間隔の繰り上がり条件
  static String intervalStepUpConditionText(int number) {
    return "${t['answerSettings.interval_step_up_condition_$number']}";
  }

  // 復習解除条件
  static String reviewDeleteConditionText(int number) {
    return "${t['answerSettings.review_delete_condition_$number']}";
  }

  // 復習通知時間
  static String reviewNotificationTimer(int settingNumber) {
    String condition = '';
    switch (settingNumber) {
      case 1:
        condition = '1:00 AM';
        break;
      case 2:
        condition = '2:00 AM';
        break;
      case 3:
        condition = '3:00 AM';
        break;
      case 4:
        condition = '4:00 AM';
        break;
      case 5:
        condition = '5:00 AM';
        break;
      case 6:
        condition = '6:00 AM';
        break;
      case 7:
        condition = '7:00 AM';
        break;
      case 8:
        condition = '8:00 AM';
        break;
      case 9:
        condition = '9:00 AM';
        break;
      case 10:
        condition = '10:00 AM';
        break;
      case 11:
        condition = '11:00 AM';
        break;
      case 12:
        condition = '12:00 PM';
        break;
      case 13:
        condition = '1:00 PM';
        break;
      case 14:
        condition = '2:00 PM';
        break;
      case 15:
        condition = '3:00 PM';
        break;
      case 16:
        condition = '4:00 PM';
        break;
      case 17:
        condition = '5:00 PM';
        break;
      case 18:
        condition = '6:00 PM';
        break;
      case 19:
        condition = '7:00 PM';
        break;
      case 20:
        condition = '8:00 PM';
        break;
      case 21:
        condition = '9:00 PM';
        break;
      case 22:
        condition = '10:00 PM';
        break;
      case 23:
        condition = '11:00 PM';
        break;
      default:
        condition = '';
        break;
    }
    return condition;
  }

  // 弱点に指定する条件
  static String weaknessCondition(int number) {
    return "${t['answerSettings.weakness_condition_$number']}";
  }

  // 克服する条件
  static String overcomingCondition(int number) {
    if ([0, 1, 120].contains(number)) {
      return "${t['answerSettings.overcoming_condition_$number']}";
    } else {
      return t.answerSettings.overcoming_condition_i(percentage: number);
    }
  }
}
