import 'package:flutter/material.dart';

class AnswerReadAloudNavigationObserver extends NavigatorObserver {
  AnswerReadAloudNavigationObserver({required this.onPageRouteChanged});

  final VoidCallback onPageRouteChanged;

  bool _isPageRoute(Route<dynamic>? route) => route is PageRoute<dynamic>;

  void _notifyIfPageRoute(Route<dynamic>? route) {
    if (_isPageRoute(route)) {
      onPageRouteChanged();
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (previousRoute == null) return;
    _notifyIfPageRoute(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _notifyIfPageRoute(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (_isPageRoute(newRoute) || _isPageRoute(oldRoute)) {
      onPageRouteChanged();
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    _notifyIfPageRoute(route);
  }
}
