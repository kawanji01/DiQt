import 'package:booqs_mobile/models/drill_lap.dart';

class DrillLapBuilder {
  DrillLap build({
    int clearsCount = 0,
    bool cleared = false,
  }) {
    return DrillLap(
      id: 1,
      userId: 1,
      drillId: 0,
      clearsCount: clearsCount,
      cleared: cleared,
      lastAnsweredAt: DateTime.now(),
      clearedAt: DateTime.now(),
      updatedAt: DateTime.now(),
      createdAt: DateTime.now(),
    );
  }
}
