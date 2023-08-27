import 'package:booqs_mobile/components/button/dialog_close_button.dart';
import 'package:booqs_mobile/data/remote/inquiry.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class InquiryForm extends StatefulWidget {
  const InquiryForm({super.key});

  @override
  State<InquiryForm> createState() => _InquiryFormState();
}

class _InquiryFormState extends State<InquiryForm> {
  bool _isRequesting = false;
  bool _isSubmitted = false;
  final _formKey = GlobalKey<FormState>();
  final _contactController = TextEditingController();

  @override
  void dispose() {
    _contactController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isRequesting = true;
    });

    EasyLoading.show(status: 'loading...');
    final Map resMap = await RemoteInquiries.create(_contactController.text);
    EasyLoading.dismiss();
    setState(() {
      _isRequesting = false;
    });
    if (!mounted) return;
    if (ErrorHandler.isErrorMap(resMap)) {
      final snackBar =
          SnackBar(content: Text(t.inquiries.sending_inquiry_failed));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      setState(() {
        _isSubmitted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isSubmitted) {
      return Column(
        children: [
          Text(t.inquiries.inquiry_sent,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.black87)),
          const SizedBox(height: 24),
          const DialogCloseButton(),
        ],
      );
    }
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            t.inquiries.contact_form_placeholder,
            style: const TextStyle(
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
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: t.inquiries.content,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return t.errors.cant_be_blank;
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
              onPressed: _isRequesting
                  ? null
                  : () {
                      _submit();
                    },
              icon: const Icon(Icons.send, color: Colors.white),
              label: Text(
                t.shared.send,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
