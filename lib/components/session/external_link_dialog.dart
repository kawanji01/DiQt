import 'dart:convert';
import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/device_info_service.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ExternalLinkDialog extends ConsumerStatefulWidget {
  const ExternalLinkDialog({super.key, this.redirectPath});

  final String? redirectPath;
  @override
  ExternalLinkDialogState createState() => ExternalLinkDialogState();
}

class ExternalLinkDialogState extends ConsumerState<ExternalLinkDialog> {
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
    final deviceInfo = DeviceInfoService();
    final String deviceIdentifier = await deviceInfo.getIndentifier();
    final Uri url =
        Uri.parse('${DiQtURL.root()}/api/v1/mobile/sessions/onetime_passcode');
    final http.Response res = await HttpService.post(url, {
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
      final String locale = ref.watch(localeProvider);
      // ワンタイムパスコードがない場合は、直接URLにリダイレクトする
      String url = "${DiQtURL.root(locale: locale)}/$_redirectPath";
      // ワンタイムパスコードがある場合は、パスコードを使ってログインさせてからリダイレクトさせる。
      if (_onetimePasscode != null) {
        url =
            "${DiQtURL.root(locale: locale)}/api/v1/mobile/sessions/verify_onetime_passcode?onetime_passcode=$_onetimePasscode";
      }
      WebPageLauncher.openByExternalBrowser(url);
    }

    // ダイアログの中身を生成する
    Widget buildExternalLinkDialog() {
      return Text(t.sessions.confirm_web_diqt);
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
            child: Text(t.sessions.okay,
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
            child: Text(
              t.sessions.okay,
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
      title: Text(
        t.sessions.external_link,
        style: TextStyle(fontWeight: FontWeight.w800),
      ),
      content: buildExternalLinkDialog(),
      actions: [
        linkButton(),
      ],
    );
  }
}
