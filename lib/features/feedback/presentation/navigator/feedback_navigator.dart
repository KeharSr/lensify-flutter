import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/feedback/presentation/view/feedback_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// provider
final feedbackViewNavigatorProvider = Provider((ref) => FeedbackNavigator());

class FeedbackNavigator with FeedbackViewRoute {}

mixin FeedbackViewRoute {
  openFeedbackView() {
    NavigateRoute.popAndPushRoute(const FeedbackView());
  }
}
