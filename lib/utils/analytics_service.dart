import 'package:booqs_mobile/utils/env_handler.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  late final FirebaseAnalytics firebaseAnalyticsInstance;

  AnalyticsService._() {
    firebaseAnalyticsInstance = FirebaseAnalytics.instance;
  }
  
  static final _singleton = AnalyticsService._();
  factory AnalyticsService() => _singleton;

  Future<void> logBeginCheckout() async {
    if (EnvHandler.isProd()) {
      firebaseAnalyticsInstance.logBeginCheckout();
    }
  }

  Future<void> setCurrentScreen(String screenName) async {
    if (EnvHandler.isProd()) {
      await firebaseAnalyticsInstance.logScreenView(screenName: screenName);
    }
  }

  Future<void> logPremiumPlanView() async {
    if (EnvHandler.isProd()) {
      await firebaseAnalyticsInstance.logEvent(
        name: 'premium_plan_view',
        parameters: {
          'page': 'premium_plan_page',
        },
      );
    }
  }

  Future<void> logPurchaseAttempt(String planType) async {
    if (EnvHandler.isProd()) {
      await firebaseAnalyticsInstance.logEvent(
        name: 'purchase_attempt',
        parameters: {
          'plan_type': planType,
          'page': 'premium_plan_page',
        },
      );
    }
  }

  Future<void> logPurchaseSuccess(String planType) async {
    if (EnvHandler.isProd()) {
      await firebaseAnalyticsInstance.logPurchase(
        currency: 'JPY',
        value: planType == 'monthly' ? 500.0 : 4800.0,
        parameters: {
          'plan_type': planType,
          'page': 'premium_plan_page',
        },
      );
    }
  }

  Future<void> logPurchaseFailed(String planType) async {
    if (EnvHandler.isProd()) {
      await firebaseAnalyticsInstance.logEvent(
        name: 'purchase_failed',
        parameters: {
          'plan_type': planType,
          'page': 'premium_plan_page',
        },
      );
    }
  }
}
