import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

// ~分前のようなタイムスタンプを表示する ref: https://zenn.dev/namioto/articles/0e0034f3b93874
String createTimeAgoString(DateTime dateTime) {
  // デフォルトでロードされている英語・スペイン語以外は明示的にロードが必要
  // timeago.setLocaleMessages('ja', timeago.JaMessages());
  final now = DateTime.now();
  final difference = now.difference(dateTime);
  return timeago.format(now.subtract(difference), locale: Intl.defaultLocale);
}

// 週の最初の日を取得する ref: https://coflutter.com/dart-flutter-how-to-find-the-first-date-and-the-last-date-of-a-week/
/// Find the first date of the week which contains the provided date.
DateTime findFirstDateOfTheWeek(DateTime dateTime) {
  return dateTime.subtract(Duration(days: dateTime.weekday - 1));
}

// 週の最後の日を取得する
/// Find last date of the week which contains provided date.
DateTime findLastDateOfTheWeek(DateTime dateTime) {
  return dateTime.add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
}

class DateTimeFormatter {
  // String→DateTime変換
  // ref: https://qiita.com/kawarabasami/items/bd3a22c7a06d17340c62
  static DateTime datetime(String datetimeStr) {
    DateTime result;
    // "2020/09/16 22:16"みたいな文字列から取る場合
    final dateFormatter = DateFormat("y/M/d HH:mm");
    result = dateFormatter.parse(datetimeStr);
    return result;
  }

  // 2023-05-02のような形式のstringを返す
  static date(DateTime datetime) {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    String formattedDate = dateFormat.format(datetime);
    return formattedDate;
  }
}
