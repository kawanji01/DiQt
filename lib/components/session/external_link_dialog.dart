import 'dart:convert';
import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/services/device_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExternalLinkDialog extends StatefulWidget {
  const ExternalLinkDialog({Key? key, this.redirectPath}) : super(key: key);

  final String? redirectPath;
  @override
  createState() => _ExternalLinkDialogState();
}

class _ExternalLinkDialogState extends State<ExternalLinkDialog> {
  String? _redirectPath;
  String? _onetimePasscode;
  bool _initDone = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _redirectPath = widget.redirectPath;
    });
    _retrivePasscode();
  }

  Future _retrivePasscode() async {
    String? token = await LocalUserInfo.authToken();
    final deviceInfo = DeviceInfoService();
    final String deviceIdentifier = await deviceInfo.getIndentifier();
    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/sessions/onetime_passcode');
    final http.Response res = await http.post(url, body: {
      'token': '$token',
      'redirect_path': '$_redirectPath',
      'device_identifier': deviceIdentifier
    });
    Map resMap = json.decode(res.body);
    setState(() {
      _onetimePasscode = resMap['onetime_passcode'];
      _initDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> moveToExternalPage() async {
      Navigator.of(context).pop();
      // ワンタイムパスコードがない場合は、直接URLにリダイレクトする
      String url = "${DiQtURL.root(context)}/$_redirectPath";
      // ワンタイムパスコードがある場合は、パスコードを使ってログインさせてからリダイレクトさせる。
      if (_onetimePasscode != null) {
        url =
            "${DiQtURL.root(context)}/api/v1/mobile/sessions/verify_onetime_passcode?onetime_passcode=$_onetimePasscode";
      }
      WebPageLauncher.openByExternalBrowser(url);
    }

    // ダイアログの中身を生成する
    Widget buildExternalLinkDialog() {
      return const Text('Web版DiQtに移動します。よろしいですか？');
    }

    Widget linkButton() {
      if (_initDone == false) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 12, right: 12, bottom: 24),
          height: 40,
          child: ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black45, //ボタンの背景色
            ),
            child: const Text('OK',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white)),
          ),
        );
      } else {
        return Container(
          margin: const EdgeInsets.only(left: 12, right: 12, bottom: 24),
          width: MediaQuery.of(context).size.width,
          height: 40,
          child: ElevatedButton(
            onPressed: () => moveToExternalPage(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green, //ボタンの背景色
            ),
            child: const Text(
              'OK',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white),
            ),
          ),
        );
      }
    }

    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(
          horizontal: ResponsiveValues.horizontalMargin(context)),
      title: const Text(
        '外部リンク',
        style: TextStyle(fontWeight: FontWeight.w800),
      ),
      content: buildExternalLinkDialog(),
      actions: [
        linkButton(),
      ],
    );
  }
}
