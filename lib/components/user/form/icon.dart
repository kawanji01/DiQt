import 'package:booqs_mobile/components/button/small_outline_green_button.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/components/user/form/password_setting_recommendation.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/remote/users.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class UserFormIcon extends ConsumerStatefulWidget {
  const UserFormIcon({super.key});

  @override
  UserFormIconState createState() => UserFormIconState();
}

class UserFormIconState extends ConsumerState<UserFormIcon> {
  bool _isRequesting = false;
  //
  void _uploadImage() async {
    if (_isRequesting == true) return;
    try {
      setState(() => _isRequesting = true);
      // 画像を選択
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        EasyLoading.show(status: 'loading...');
        final Map resMap = await RemoteUsers.uploadIcon(image: image);
        EasyLoading.dismiss();
        setState(() => _isRequesting = false);
        if (!mounted) return;
        if (ErrorHandler.isErrorMap(resMap)) {
          return ErrorHandler.showErrorSnackBar(context, resMap);
        }
        // currentUserの再読み込みでアイコンを再描画
        ref.invalidate(asyncCurrentUserProvider);
        final snackBar = SnackBar(content: Text(t.shared.update_succeeded));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        setState(() => _isRequesting = false);
      }
    } on PlatformException catch (e) {
      setState(() => _isRequesting = false);

      final snackBar =
          SnackBar(content: Text('${t.errors.error_occured} / $e'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(asyncCurrentUserProvider).when(
          data: (user) {
            if (user == null) return Container();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: CircleAvatar(
                    radius: 72.0,
                    backgroundColor: Colors.transparent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: CachedNetworkImage(
                        imageUrl: '${user.iconImageUrl}',
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            Image.asset('assets/images/not_found_icon.png'),
                        fit: BoxFit.cover,
                        width: 200,
                        height: 200,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: InkWell(
                    onTap: () => _isRequesting ? true : _uploadImage(),
                    child: SmallOutlineGreenButton(
                      label: t.users.set_icon,
                      icon: Icons.image_outlined,
                    ),
                  ),
                ),
                const UserFormPasswordSettingRecommendation(),
              ],
            );
          },
          error: (err, stack) => Text('Error: $err'),
          loading: () => const LoadingSpinner(),
        );
  }
}
