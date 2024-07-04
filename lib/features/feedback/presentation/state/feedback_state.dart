class FeedbackState {
  final bool showFeedbackDialog;

  FeedbackState({required this.showFeedbackDialog});

  factory FeedbackState.initial() {
    return FeedbackState(showFeedbackDialog: false);
  }

  FeedbackState copyWith({bool? showFeedbackDialog}) {
    return FeedbackState(
      showFeedbackDialog: showFeedbackDialog ?? this.showFeedbackDialog,
    );
  }
}
