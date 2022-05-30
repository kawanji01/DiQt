import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/ad/app_banner.dart';
import 'package:booqs_mobile/utils/push_notification.dart';
import 'package:booqs_mobile/widgets/notice/item_list_view.dart';
import 'package:booqs_mobile/widgets/shared/entrance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoticeIndexPage extends ConsumerStatefulWidget {
  const NoticeIndexPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    // return Navigator.of(context).pushNamed(notificationIndexPage);
    // アニメーションなしで画面遷移させる。 参考： https://stackoverflow.com/questions/49874272/how-to-navigate-to-other-page-without-animation-flutter
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        // 画面遷移のログを送信するために、settings.nameを設定する。
        settings: const RouteSettings(name: noticeIndexPage),
        pageBuilder: (context, animation1, animation2) =>
            const NoticeIndexPage(),
        transitionDuration: Duration.zero,
      ),
    );
  }

  @override
  _NoticeIndexPageState createState() => _NoticeIndexPageState();
}

class _NoticeIndexPageState extends ConsumerState<NoticeIndexPage> {
  User? _user;

  @override
  void initState() {
    super.initState();
    PushNotification.initialize(context);
  }

  @override
  Widget build(BuildContext context) {
    _user = ref.watch(currentUserProvider);

    if (_user == null) return const Entrance();

    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: const <Widget>[
            //_notificationsPageButton(),
            NoticeItemListView(),
            SizedBox(
              height: 80,
            ),
            AppBanner(),
          ],
        ),
      ),
    );
  }
}
