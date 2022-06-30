import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/data/remote/notes.dart';
import 'package:booqs_mobile/models/note.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/widgets/button/small_green_button.dart';
import 'package:booqs_mobile/widgets/shared/item_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class QuizNote extends StatefulWidget {
  const QuizNote({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  State<QuizNote> createState() => _QuizNoteState();
}

class _QuizNoteState extends State<QuizNote> {
  bool _isEdit = true;
  Note? _note;
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final Quiz quiz = widget.quiz;
    if (quiz.note == null) return;
    setState(() {
      _note = quiz.note;
      _isEdit = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _contentController.dispose();
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
          'content': _contentController.text,
        };
        resMap = await RemoteNotes.create(params);
      } else {
        // update
        final Map<String, dynamic> params = {
          'id': _note!.id,
          'quiz_id': widget.quiz.id,
          'content': _contentController.text,
        };
        resMap = await RemoteNotes.update(params);
      }
      EasyLoading.dismiss();
      if (resMap == null) return;
      final Note note = Note.fromJson(resMap['note']);
      setState(() {
        _note = note;
        _isEdit = false;
      });
    }

    Widget _noteForm() {
      _contentController.text = _note?.content ?? '';
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SharedItemLabel(text: 'ノート'),
            const SizedBox(height: 16),
            // 入力フォーム
            TextFormField(
              controller: _contentController,
              minLines: 4,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                filled: true,
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                labelText: "問題に関する自分用のメモ",
                labelStyle: TextStyle(color: Colors.black54),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return '空欄のノートは作成できません。';
                }
                return null;
              },
            ),
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
    }

    Widget _noteText() {
      if (_note == null) return const Text('Note does not exist.');
      return Column(
        children: [
          const SharedItemLabel(text: 'ノート'),
          const SizedBox(height: 8),
          Text(
            _note!.content,
            style: const TextStyle(fontSize: 16),
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

    if (_isEdit) {
      return _noteForm();
    } else {
      return _noteText();
    }
  }
}
