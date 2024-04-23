import 'package:booqs_mobile/components/form/editor_comment.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';

class SharedDeleteConfirmationWithComment extends StatelessWidget {
  const SharedDeleteConfirmationWithComment(
      {super.key,
      required this.onDeletePressed,
      required this.commentController,
      required this.formKey,
      required this.emptyValidation});
  final void Function() onDeletePressed;
  final TextEditingController commentController;
  final GlobalKey<FormState> formKey;
  final bool emptyValidation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveValues.dialogWidth(context),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t.shared.destroy_confirmation,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
              const SizedBox(height: 16),
              Text(t.shared.destroy_confirmation_description,
                  style: const TextStyle(fontSize: 16, color: Colors.black87)),
              const SizedBox(height: 16),
              FormEditorComment(
                commentController: commentController,
                emptyValidation: emptyValidation,
                label: t.shared.destroy_comment,
                hint: t.shared.destroy_comment_placeholder,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 40),
                ),
                onPressed: () {
                  onDeletePressed();
                },
                icon: const Icon(Icons.delete, color: Colors.white),
                label: Text(
                  t.shared.destroy,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
