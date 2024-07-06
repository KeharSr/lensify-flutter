import 'dart:async';

import 'package:final_assignment/features/feedback/presentation/state/feedback_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

final feedbackViewModelProvider =
    StateNotifierProvider<FeedbackViewModel, FeedbackState>(
        (ref) => FeedbackViewModel());

class FeedbackViewModel extends StateNotifier<FeedbackState> {
  FeedbackViewModel() : super(FeedbackState.initial()) {
    startListeningToGyroscope();
  }

  StreamSubscription? _gyroscopeSubscription;
  DateTime? _lastShakeTimestamp;
  List<double> _shakeHistory = [];

  void startListeningToGyroscope() {
    _gyroscopeSubscription = gyroscopeEventStream().listen((event) {
      final now = DateTime.now();
      final double rotationRate = event.x.abs() + event.y.abs() + event.z.abs();
      print(
          "Rotation Rate: $rotationRate, time since last shake: ${now.difference(_lastShakeTimestamp ?? now)}");

      if (_lastShakeTimestamp == null ||
          now.difference(_lastShakeTimestamp!) > Duration(milliseconds: 300)) {
        // Decreased debounce duration
        _lastShakeTimestamp = now;
        _shakeHistory.add(rotationRate);
        if (_shakeHistory.length > 10) _shakeHistory.removeAt(0);
        if (_isShakePattern()) {
          _handleShakeEvent();
          _shakeHistory.clear();
        }
      }
    });
  }

  bool _isShakePattern() {
    int shakeCount = _shakeHistory
        .where((rate) => rate > 3.0)
        .length; // Lowered threshold for shake detection
    print("Shake count: $shakeCount");
    return shakeCount >= 3;
  }

  void stopListeningToGyroscope() {
    _gyroscopeSubscription?.cancel();
  }

  void _handleShakeEvent() {
    state = state.copyWith(showFeedbackDialog: true);
  }

  void setShowFeedbackDialog(bool value) {
    state = state.copyWith(showFeedbackDialog: value);
  }

  @override
  void dispose() {
    stopListeningToGyroscope();
    super.dispose();
  }
}

Stream<GyroscopeEvent> gyroscopeEventStream() async* {
  await for (final event in gyroscopeEvents) {
    yield event;
  }
}
