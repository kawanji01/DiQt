import 'dart:convert';
import 'package:booqs_mobile/utils/device_indentifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ExternalLinkDialog extends StatefulWidget {
  const ExternalLinkDialog({Key? key, this.redirectPath}) : super(key: key);

  final String? redirectPath;
  @override
  _ExternalLinkDialogState createState() => _ExternalLinkDialogState();
}

class _ExternalLinkDialogState extends State<ExternalLinkDialog> {
  String? _redirectPath;
  String? _onetimePasscode;

  void initState() {
    super.initState();
    setState(() {
      _redirectPath = widget.redirectPath;
    });
    _retrivePasscode();
  }

  Future _retrivePasscode() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    String deviceIdentifier = await DeviceIndentifier.get(context);
    var url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/sessions/onetime_passcode');
    http.Response res = await http.post(url, body: {
      'token': '$token',
      'redirect_path': '$_redirectPath',
      'device_identifier': deviceIdentifier
    });
    Map resMap = json.decode(res.body);
    setState(() {
      _onetimePasscode = resMap['onetime_passcode'];
    });
  }

  Future _moveToExternalPage() async {
    Navigator.of(context).pop();
    if (_onetimePasscode == null) return;
    final url =
        "${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/sessions/verify_onetime_passcode?onetime_passcode=$_onetimePasscode";
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    }
  }

  // ダイアログの中身を生成する
  Widget _buildExternalLinkDialog() {
    return const Text('Web版BooQsに移動します。よろしいですか？');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('外部リンク'),
      content: _buildExternalLinkDialog(),
      actions: [
        Container(
          margin: const EdgeInsets.only(left: 12, right: 12, bottom: 24),
          width: MediaQuery.of(context).size.width,
          height: 40,
          child: ElevatedButton(
            onPressed: () => _moveToExternalPage(),
            child: const Text('OK',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          ),
        ),
      ],
    );
  }
}
