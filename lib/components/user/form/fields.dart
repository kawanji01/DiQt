import 'package:booqs_mobile/components/button/medium_green_button.dart';
import 'package:booqs_mobile/components/user/form/lang_number.dart';
import 'package:booqs_mobile/components/user/form/learning_lang_number.dart';
import 'package:booqs_mobile/components/user/form/withdrawal_button.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/data/remote/users.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
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
  bool _isRequesting = false;

  @override
  // widgetの破棄時にコントローラも破棄する。Controllerを使うなら必ず必要。
  // 参考： https://api.flutter.dev/flutter/widgets/TextEditingController-class.html
  void dispose() {
    _nameController.dispose();
    _profileController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _nameController.text = widget.user.name;
      _profileController.text = widget.user.profile ?? '';
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // 画像
    Future save(User user) async {
      // 各Fieldのvalidatorを呼び出す
      if (!_formKey.currentState!.validate()) return;
      setState(() => _isRequesting = true);
      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      final Map<String, dynamic> params = {
        'id': user.id,
        'public_uid': user.publicUid,
        'name': _nameController.text,
        'profile': _profileController.text,
        'lang_number': ref.watch(userLangNumberProvider),
        'learning_lang_number': ref.watch(userLearningLangNumberProvider),
      };
      try {
        final Map? resMap = await RemoteUsers.update(params);
        await EasyLoading.dismiss();
        setState(() => _isRequesting = false);

        if (resMap == null ||
            resMap['user'] == null ||
            resMap['message'] == null) {
          if (!mounted) return;
          final snackBar = SnackBar(content: Text(t.shared.update_failed));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          final updatedUser = User.fromJson(resMap['user']);
          // ユーザーの更新
          await ref.read(currentUserProvider.notifier).logIn(updatedUser);
          // Localeの更新
          await ref.read(localeProvider.notifier).setLocale();
          final snackBar = SnackBar(content: Text(t.shared.update_succeeded));
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          UserMyPage.push(context);
        }
      } catch (e) {
        // エラーハンドリング
        await EasyLoading.dismiss();
        setState(() => _isRequesting = false);
        if (!mounted) return;
        final snackBar =
            SnackBar(content: Text('${t.errors.error_occured}: $e'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
              const SizedBox(height: 64),
              InkWell(
                  onTap: _isRequesting
                      ? null
                      : () async {
                          save(widget.user);
                        },
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
