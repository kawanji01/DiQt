import 'package:booqs_mobile/components/note/confirmation_screen.dart';
import 'package:booqs_mobile/components/note/content.dart';
import 'package:booqs_mobile/components/note/form.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/remote/notes.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/note.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/pages/user/premium_plan.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoteItem extends ConsumerStatefulWidget {
  const NoteItem({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  NoteItemState createState() => NoteItemState();
}

class NoteItemState extends ConsumerState<NoteItem> {
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

  Future<void> _save() async {
    EasyLoading.show(status: 'loading...');
    final Map resMap = _note == null ? await _create() : await _update();
    EasyLoading.dismiss();
    if (!mounted) return;
    if (ErrorHandler.isErrorMap(resMap)) {
      return ErrorHandler.showErrorSnackBar(context, resMap);
    }
    final Note note = Note.fromJson(resMap['note']);
    _noteContentController.text = note.content;
    setState(() {
      _note = note;
      _isEdit = false;
    });
  }

  Future<Map> _create() async {
    final Map<String, dynamic> params = {
      'quiz_id': widget.quiz.id,
      'content': _noteContentController.text,
    };
    final Map resMap = await RemoteNotes.create(params);
    return resMap;
  }

  Future<Map> _update() async {
    // update
    final Map<String, dynamic> params = {
      'id': _note!.id,
      'quiz_id': widget.quiz.id,
      'content': _noteContentController.text,
    };
    final Map resMap = await RemoteNotes.update(params);
    return resMap;
  }

  Future<void> _destroy() async {
    EasyLoading.show(status: 'loading...');
    final Map resMap = await RemoteNotes.destroy(_note!.id);
    EasyLoading.dismiss();
    if (!mounted) return;
    if (ErrorHandler.isErrorMap(resMap)) {
      return ErrorHandler.showErrorSnackBar(context, resMap);
    }
    _noteContentController.text = '';
    setState(() {
      _note = null;
      _isEdit = true;
    });
  }

  // プレミアムプランページに遷移
  void _moveToPremiumPlan() {
    final snackBar = SnackBar(content: Text(t.notes.paywall_message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    PremiumPlanPage.push(context);
  }

  @override
  Widget build(BuildContext context) {
    final bool isPremium = ref.watch(premiumEnabledProvider);
    // FocusScope.of(context).unfocus();

    Widget content() {
      if (_isEdit) {
        // Note編集画面
        return NoteForm(
          formKey: _formKey,
          noteContentController: _noteContentController,
          onSave: isPremium ? _save : _moveToPremiumPlan,
        );
      } else {
        // Noteのコンテンツ表示
        return NoteContent(
          note: _note,
          quiz: widget.quiz,
          onEdit: () =>
              isPremium ? setState(() => _isEdit = true) : _moveToPremiumPlan(),
          onDestroy: () async {
            if (isPremium == false) {
              return _moveToPremiumPlan();
            }
            final bool? result = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) => NoteConfirmationDialog(
                      noteId: _note!.id,
                    ));
            if (result == true) {
              _destroy();
            }
          },
        );
      }
    }

    return GestureDetector(
      onTap: () {
        // キーボードを閉じる
        FocusScopeNode currentFocus = FocusScope.of(context);
        // フォーカスがすでにない状況でunfocus()を呼び出すと、エラーが発生する可能性がある
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: content(),
    );
  }
}
