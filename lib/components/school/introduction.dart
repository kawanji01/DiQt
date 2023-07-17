import 'package:booqs_mobile/models/school.dart';
import 'package:flutter/material.dart';

class SchoolIntroduction extends StatelessWidget {
  const SchoolIntroduction({Key? key, required this.school}) : super(key: key);
  final School school;

  @override
  Widget build(BuildContext context) {
    if (school.introduction == '') return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          school.name,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        Text(school.introduction ?? '',
            style: const TextStyle(fontSize: 16, color: Colors.black87)),
      ],
    );
  }
}
