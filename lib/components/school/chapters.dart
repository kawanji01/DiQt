import 'package:booqs_mobile/components/chapter/card_list.dart';
import 'package:booqs_mobile/data/provider/school.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchoolChapters extends ConsumerStatefulWidget {
  const SchoolChapters({Key? key}) : super(key: key);

  @override
  SchoolChaptersState createState() => SchoolChaptersState();
}

class SchoolChaptersState extends ConsumerState<SchoolChapters> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(asynSchoolChaptersProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    //final School? school = ref.watch(schoolProvider);
    final future = ref.watch(asynSchoolChaptersProvider);

    //
    Widget buildCards() {
      return future.when(
          loading: () => const LoadingSpinner(),
          error: (err, stack) => Text('Error: $err'),
          data: (chapters) => ChapterCardList(chapters: chapters!));
    }

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 16,
            ),
            buildCards(),
          ],
        ),
      ),
    );
  }
}
