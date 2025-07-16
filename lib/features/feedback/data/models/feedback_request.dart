class FeedbackRequest {
  final String type;
  final String station;
  final String content;

  FeedbackRequest({
    required this.type,
    required this.station,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'feedbackTypeId': type,
      'content': content,
      'stationId': station,
    };
  }

}