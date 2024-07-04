import 'dart:async';

import 'package:final_assignment/features/feedback/presentation/state/feedback_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

final feedbackViewModelProvider =
    StateNotifierProvider<FeedbackViewModel, FeedbackState>(
        (ref) => FeedbackViewModel());

class FeedbackViewModel extends StateNotifier<FeedbackState> {
  FeedbackViewModel() : super(FeedbackState.initial()) {
    startListeningToAccelerometer();
  }

  StreamSubscription? _accelerometerSubscription;
  DateTime? _lastShakeTimestamp;

  void startListeningToAccelerometer() {
    _accelerometerSubscription = accelerometerEvents.listen((event) {
      final now = DateTime.now();
      if (_lastShakeTimestamp == null ||
          now.difference(_lastShakeTimestamp!) > Duration(seconds: 1)) {
        final threshold = 12.0; // Adjust this threshold based on your needs
        final acceleration =
            event.x * event.x + event.y * event.y + event.z * event.z;
        if (acceleration > threshold * threshold) {
          _lastShakeTimestamp = now;
          _handleShakeEvent();
        }
      }
    });
  }

  void stopListeningToAccelerometer() {
    _accelerometerSubscription?.cancel();
  }

  void _handleShakeEvent() {
    state = state.copyWith(showFeedbackDialog: true);
  }

  void setShowFeedbackDialog(bool value) {
    state = state.copyWith(showFeedbackDialog: value);
  }

  @override
  void dispose() {
    stopListeningToAccelerometer();
    super.dispose();
  }
}
