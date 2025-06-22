import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchHistoryOrderProvider = StateProvider<String>((ref) {
  return 'created_at-desc';
});

final searchHistoryDeviceTypeProvider = StateProvider<String>((ref) {
  return '';
});
