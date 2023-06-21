import 'package:booqs_mobile/components/button/medium_green_button.dart';
import 'package:booqs_mobile/components/user/form/authentication.dart';
import 'package:booqs_mobile/components/user/form/icon.dart';
import 'package:booqs_mobile/components/user/form/lang_number.dart';
import 'package:booqs_mobile/components/user/form/learning_lang_number.dart';
import 'package:booqs_mobile/components/user/form/mail_delivered.dart';
import 'package:booqs_mobile/components/user/form/time_zone_name.dart';
import 'package:booqs_mobile/components/user/form/withdrawal_button.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/remote/users.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserFormFields extends ConsumerStatefulWidget {
  const UserFormFields({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  UserFormFieldsState createState() => UserFormFieldsState();
}

class UserFormFieldsState extends ConsumerState<UserFormFields> {
  // validatorを利用するために必要なkey
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _profileController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController(text: '');
  final _passwordConfirmationController = TextEditingController(text: '');

  bool _isRequesting = false;

  @override
  // widgetの破棄時にコントローラも破棄する。Controllerを使うなら必ず必要。
  // 参考： https://api.flutter.dev/flutter/widgets/TextEditingController-class.html
  void dispose() {
    _nameController.dispose();
    _profileController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.name;
    _profileController.text = widget.user.profile ?? '';
    _emailController.text = widget.user.email;
  }

  Future<void> _save() async {
    // 各Fieldのvalidatorを呼び出す
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isRequesting = true);
    EasyLoading.show(status: 'loading...');
    final Map<String, dynamic> params = {
      'id': widget.user.id,
      'public_uid': widget.user.publicUid,
      'name': _nameController.text,
      'profile': _profileController.text,
      'lang_number': ref.watch(userLangNumberProvider),
      'learning_lang_number': ref.watch(userLearningLangNumberProvider),
      'time_zone_name': ref.watch(userTimeZoneNameProvider),
      'mail_delivered': ref.watch(userMailDeliveredProvider),
      'email': _emailController.text,
      'password': _passwordController.text,
      'password_confirmation': _passwordConfirmationController.text,
    };

    final Map resMap =
        await RemoteUsers.update(params: params, locale: widget.user.locale());
    await EasyLoading.dismiss();
    setState(() => _isRequesting = false);
    if (!mounted) return;
    if (ErrorHandler.isErrorMap(resMap)) {
      // 失敗
      ErrorHandler.showErrorSnackBar(context, resMap, serverSideMessage: true);
    } else {
      // 成功
      final updatedUser = User.fromJson(resMap['user']);
      final snackBar = SnackBar(content: Text(t.users.updated));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      UserMyPage.push(context);
      // ユーザーの更新
      await ref.read(currentUserProvider.notifier).logIn(updatedUser);
      // Localeの更新
      // await ref.read(localeProvider.notifier).setLocale();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const UserFormIcon(),
                  const SizedBox(height: 40),
                  // 項目フォーム
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: t.users.name),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return t.errors.cant_be_blank;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 40),
                  TextFormField(
                    // 複数行のフォーム。 参考： https://stackoverflow.com/questions/54972928/how-to-expand-a-textfield-in-flutter-looks-like-a-text-area
                    minLines: 8,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: _profileController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: t.users.profile,
                      hintText: t.users.profile_placeholder,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const UserFormLangNumber(),
              const SizedBox(height: 32),
              const UserFormLearningLangNumber(),
              const SizedBox(height: 32),
              const UserFormTimeZoneName(),
              const SizedBox(height: 48),
              const UserFormMailDelivered(),
              const SizedBox(height: 48),
              UserFormAuthentication(
                emailController: _emailController,
                passwordController: _passwordController,
                passwordConfirmationController: _passwordConfirmationController,
              ),
              const SizedBox(height: 80),
              InkWell(
                  onTap: _isRequesting ? null : _save,
                  child: MediumGreenButton(
                    label: t.shared.update,
                    icon: Icons.edit_outlined,
                    fontSize: 18,
                  )),
              const SizedBox(height: 80),
              const UserFormWithdrawalButton(),
              const SizedBox(height: 80),
            ]));
  }
}
