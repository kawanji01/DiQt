import 'package:flutter_riverpod/flutter_riverpod.dart';

final noteOrderProvider = StateProvider<String>((ref) => 'created_at-desc');
