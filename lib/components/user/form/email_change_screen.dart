import 'package:booqs_mobile/components/button/medium_green_button.dart';
import 'package:booqs_mobile/components/heading/medium_green.dart';
import 'package:booqs_mobile/components/session/form_field.dart';
import 'package:booqs_mobile/data/remote/users.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UserFormEmailChangeScreen extends StatefulWidget {
  const UserFormEmailChangeScreen({super.key});

  @override
  State<UserFormEmailChangeScreen> createState() =>
      _UserFormEmailChangeScreenState();
}

class _UserFormEmailChangeScreenState extends State<UserFormEmailChangeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: '');

  bool _isRequesting = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  Future _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() => _isRequesting = true);
    // 画面全体にローディングを表示
    EasyLoading.show(status: 'loading...');
    final Map resMap =
        await RemoteUsers.updateEmail(email: _emailController.text);
    EasyLoading.dismiss();
    setState(() => _isRequesting = false);
    if (!mounted) return;
    Navigator.of(context).pop();
    if (ErrorHandler.isErrorMap(resMap)) {
      _emailController.clear();
      ErrorHandler.showErrorSnackBar(context, resMap, serverSideMessage: true);
    } else {
      final snackBar =
          SnackBar(content: Text(t.users.email_change_email_resent));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      UserMyPage.push(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 80%の高さで表示する。
    SizeConfig().init(context);
    final double grid = SizeConfig.blockSizeVertical ?? 0;
    final double height = grid * 80;

    return SizedBox(
      height: height,
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  HeadingMediumGreen(
                    label: t.users.email_change,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    t.users.email_change_cta_text,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  SessionFormField(
                    label: t.users.new_email,
                    controller: _emailController,
                    isPassword: false,
                    keyText: 'emailField',
                  ),
                  const SizedBox(height: 48),
                  InkWell(
                      onTap: _isRequesting
                          ? null
                          : () {
                              _submit();
                            },
                      child: MediumGreenButton(
                        fontSize: 16,
                        label: t.users.change_email,
                        icon: null,
                      )),
                ],
              )),
        ),
      ),
    );
  }
}
