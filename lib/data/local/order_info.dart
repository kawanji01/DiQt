import 'package:booqs_mobile/consts/orders.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalOrderInfo {
  static Future<String> reviewOrder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? reviewOrder = prefs.getString('review_order');
    if (reviewOrderList.contains(reviewOrder)) {
      if (reviewOrder == null) return defaultReviewOrder;
      return reviewOrder;
    } else {
      return defaultReviewOrder;
    }
  }

  static Future<void> writeReviewInfo(String? reviewOrder) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (reviewOrderList.contains(reviewOrder)) {
      await prefs.setString('review_order', '$reviewOrder');
    } else {
      await prefs.setString('review_order', defaultReviewOrder);
    }
  }
}
