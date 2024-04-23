import 'package:flutter/material.dart';

class ClosingPendingRequestNotification extends Notification {
  final bool closed;

  ClosingPendingRequestNotification({
    required this.closed,
  });
}
