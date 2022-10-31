import 'package:app_review/app_review.dart';
import 'package:booqs_mobile/data/remote/users.dart';

class AppReviewService {
  static void request() {
    AppReview.requestReview.then((onValue) {
      //print(onValue);
    });
  }

  static void favorApp() {
    AppReview.requestReview.then((onValue) {
      //print(onValue);
      RemoteUsers.favorApp();
    });
  }
}
