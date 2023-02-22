import 'package:booqs_mobile/data/remote/inquiry.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/button/dialog_close_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ContactFormScreen extends StatefulWidget {
  const ContactFormScreen({Key? key}) : super(key: key);

  @override
  State<ContactFormScreen> createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  bool _isSubmitted = false;
  final _formKey = GlobalKey<FormState>();
  final _contactController = TextEditingController();

  @override
  // widgetの破棄時にコントローラも破棄する。Controllerを使うなら必ず必要。
  // 参考： https://api.flutter.dev/flutter/widgets/TextEditingController-class.html
  void dispose() {
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget form() {
      if (_isSubmitted) {
        return Column(
          children: const [
            Text('お問い合わせいただき、誠にありがとうございます！！\n必要に応じて、後日メールにてご返信させていただく場合もございます。',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87)),
            SizedBox(height: 24),
            DialogCloseButton(),
          ],
        );
      }
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'ご意見やご不明点・バグの報告などございましたらなんでもご記入ください。',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 24),
            // form
            TextFormField(
              // 複数行のフォーム。 参考： https://stackoverflow.com/questions/54972928/how-to-expand-a-textfield-in-flutter-looks-like-a-text-area
              minLines: 8,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: _contactController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'お問い合わせ内容',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'お問い合わせ内容は空欄にできません。';
                }
                return null;
              },
            ),
            // SubmitBtn
            Container(
              margin: const EdgeInsets.only(top: 16),
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity,
                      40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
                ),
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;

                  EasyLoading.show(status: 'loading...');
                  await RemoteInquiries.create(_contactController.text);
                  EasyLoading.dismiss();
                  setState(() {
                    _isSubmitted = true;
                  });
                },
                icon: const Icon(Icons.send, color: Colors.white),
                label: const Text(
                  '送信する',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      height: ResponsiveValues.dialogHeight(context),
      width: ResponsiveValues.dialogWidth(context),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            const Text('お問い合わせ',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)),
            const SizedBox(height: 16),
            form(),
            const SizedBox(height: 40),
          ],
        ),
        //const DialogCloseButton(),
      ),
    );
  }
}
