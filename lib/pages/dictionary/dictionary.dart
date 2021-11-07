import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/widgets/session/external_link_dialog.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/large_button.dart';
import 'package:flutter/material.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({Key? key}) : super(key: key);

  static Future push(BuildContext context, Dictionary dictionary) async {
    return Navigator.of(context).pushNamed(
      '/dictionary/dictionary',
      arguments: dictionary,
    );
  }

  @override
  _DictionaryPageState createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  @override
  Widget build(BuildContext context) {
    // 辞書の取得
    Dictionary getDictionary() {
      return ModalRoute.of(context)!.settings.arguments as Dictionary;
    }

    final _dictionary = getDictionary();

    Future _goToRequestHistories() async {
      final String redirectPath =
          'dictionaries/${_dictionary.publicUid}/accepted_requests';
      // 外部リンクダイアログを表示
      await showDialog(
          context: context,
          builder: (context) {
            // ./locale/ を取り除いたpathを指定する
            return ExternalLinkDialog(redirectPath: redirectPath);
          });
    }

    Future _goToPendingRequests() async {
      final String redirectPath =
          'dictionaries/${_dictionary.publicUid}/pending_requests';
      // 外部リンクダイアログを表示
      await showDialog(
          context: context,
          builder: (context) {
            // ./locale/ を取り除いたpathを指定する
            return ExternalLinkDialog(redirectPath: redirectPath);
          });
    }

    Widget _requestHistoriesButton() {
      final String btnText = '変更履歴(${_dictionary.acceptedRequestsCount})';
      return InkWell(
        onTap: () {
          _goToRequestHistories();
        },
        child: LargeButton(btnText: btnText),
      );
    }

    Widget _pendingRequestsButton() {
      final String btnText = '審査中の変更（${_dictionary.pendingRequestsCount}）';
      return InkWell(
        onTap: () {
          _goToPendingRequests();
        },
        child: LargeButton(btnText: btnText),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_dictionary.title),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 32),
            _requestHistoriesButton(),
            const SizedBox(height: 32),
            _pendingRequestsButton(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavbar(selectedIndex: 0),
    );
  }
}
