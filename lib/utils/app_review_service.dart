import 'package:booqs_mobile/data/remote/users.dart';
import 'package:in_app_review/in_app_review.dart';

class AppReviewService {
  // mockで検証できるようにインスタンスメソッドにする
  Future request() async {
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }

  static Future favorApp() async {
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
      RemoteUsers.favorApp();
    }
  }
}
