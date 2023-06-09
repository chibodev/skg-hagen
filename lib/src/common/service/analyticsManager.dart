import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsManager {
  AnalyticsManager._();

  factory AnalyticsManager() => _instance;

  static final AnalyticsManager _instance = AnalyticsManager._();

  final FirebaseAnalytics _firebaseAnalytics = FirebaseAnalytics.instance;
  bool _initialized = false;

  Future<void> setScreen(String screenName, String screenClassName) async {
    if (!_initialized) {
      await _firebaseAnalytics.setCurrentScreen(
          screenName: screenName, screenClassOverride: screenClassName);
      _initialized = true;
    }
  }
}
