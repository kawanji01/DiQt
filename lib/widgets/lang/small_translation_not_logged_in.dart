import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:flutter/material.dart';

class LangSmallTranslationNotLoggedIn extends StatelessWidget {
  const LangSmallTranslationNotLoggedIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle styleText = TextStyle(fontSize: 14, color: Colors.black87);

    void _recommendSignIn() {
      const snackBar = SnackBar(content: Text('翻訳機能を利用するには、ログインが必要です。'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      UserMyPage.push(context);
    }

    return Row(
      children: [
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () => _recommendSignIn(),
          child: const Text('Google翻訳', style: TextStyle(color: Colors.green)),
        ),
        const Text(
          ' / ',
          style: styleText,
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () => _recommendSignIn(),
          child: const Text('DeepL翻訳', style: TextStyle(color: Colors.green)),
        ),
      ],
    );
  }
}
