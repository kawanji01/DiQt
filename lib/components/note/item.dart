import 'package:booqs_mobile/components/note/confirmation_screen.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/remote/notes.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/note.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/components/button/small_green_button.dart';
import 'package:booqs_mobile/components/note/form_field.dart';
import 'package:booqs_mobile/components/markdown/markdown_with_dict_link.dart';
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

  void _destroy() async {
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
    if (_isEdit) {
      // Note編集画面
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SharedItemLabel(
              text: t.notes.note,
              icon: Icons.note_alt_outlined,
            ),
            const SizedBox(height: 24),
            NoteFormField(noteContentController: _noteContentController),
            const SizedBox(height: 24),
            InkWell(
              onTap: isPremium ? _save : _moveToPremiumPlan,
              child:
                  SmallGreenButton(label: t.notes.update, icon: Icons.update),
            ),
          ],
        ),
      );
    } else {
      // Noteのコンテンツ表示
      return Column(
        children: [
          SharedItemLabel(
            text: t.notes.note,
            icon: Icons.note_alt_outlined,
          ),
          const SizedBox(height: 16),
          MarkdownWithDictLink(
            text: _note?.content ?? 'Note does not exist.',
            dictionaryId: widget.quiz.appliedDictionaryId,
            fontSize: 16,
            fontWeight: FontWeight.normal,
            fontColor: Colors.black87,
            selectable: true,
          ),
          const SizedBox(height: 24),
          InkWell(
            onTap: () => isPremium
                ? setState(() => _isEdit = true)
                : _moveToPremiumPlan(),
            child: SmallGreenButton(label: t.notes.edit, icon: Icons.edit),
          ),
          // 削除ボタン
          Container(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () async {
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
              icon: const Icon(
                Icons.delete,
                size: 16,
                color: Colors.red,
              ),
              label: Text(t.shared.destroy,
                  style: const TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                      color: Colors.red,
                      fontWeight: FontWeight.normal)),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.only(left: 0),
              ),
            ),
          ),
        ],
      );
    }
  }
}