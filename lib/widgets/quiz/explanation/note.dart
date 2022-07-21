import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/data/remote/notes.dart';
import 'package:booqs_mobile/models/note.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/widgets/button/small_green_button.dart';
import 'package:booqs_mobile/widgets/note/form_field.dart';
import 'package:booqs_mobile/widgets/shared/item_label.dart';
import 'package:booqs_mobile/widgets/shared/markdown_with_diqt_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class QuizExplanationNote extends StatefulWidget {
  const QuizExplanationNote({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  State<QuizExplanationNote> createState() => _QuizExplanationNoteState();
}

class _QuizExplanationNoteState extends State<QuizExplanationNote> {
  bool _isEdit = true;
  Note? _note;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _noteContentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final Quiz quiz = widget.quiz;
    _note = quiz.note;
    _noteContentController.text = _note?.content ?? '';
    if (quiz.note == null) return;
    setState(() {
      _note;
      _isEdit = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _noteContentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future _save() async {
      // ログインしていない場合は、ログインページへ
      final String? token = await LocalUserInfo.authToken();
      if (token == null) {
        const snackBar = SnackBar(content: Text('ノートを利用するためにはログインが必要です。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        UserMyPage.push(context);
        return;
      }
      // リクエスト
      Map? resMap;
      EasyLoading.show(status: 'loading...');
      if (_note == null) {
        // create
        final Map<String, dynamic> params = {
          'quiz_id': widget.quiz.id,
          'content': _noteContentController.text,
        };
        resMap = await RemoteNotes.create(params);
      } else {
        // update
        final Map<String, dynamic> params = {
          'id': _note!.id,
          'quiz_id': widget.quiz.id,
          'content': _noteContentController.text,
        };
        resMap = await RemoteNotes.update(params);
      }
      EasyLoading.dismiss();
      if (resMap == null) return;
      final Note note = Note.fromJson(resMap['note']);
      _noteContentController.text = note.content;
      setState(() {
        _note = note;
        _isEdit = false;
      });
    }

    if (_isEdit) {
      // Note編集画面
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SharedItemLabel(text: 'ノート'),
            const SizedBox(height: 16),
            NoteFormField(noteContentController: _noteContentController),
            const SizedBox(height: 24),
            InkWell(
              onTap: () {
                _save();
              },
              child: const SmallGreenButton(label: '更新する', icon: Icons.update),
            ),
          ],
        ),
      );
    } else {
      // Noteのコンテンツ表示
      return Column(
        children: [
          const SharedItemLabel(text: 'ノート'),
          const SizedBox(height: 8),
          MarkdownWithDiQtLink(
            text: _note?.content ?? 'Note does not exist.',
            dictionaryId: widget.quiz.dictionaryId,
            textStyle: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              setState(() => _isEdit = true);
            },
            child: const SmallGreenButton(label: '編集する', icon: Icons.edit),
          ),
        ],
      );
    }
  }
}
