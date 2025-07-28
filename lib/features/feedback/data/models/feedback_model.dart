class FeedbackModel {
  final String type;
  final String station;
  final String content;

  FeedbackModel({
    required this.type,
    required this.station,
    required this.content,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      type: json['type'] as String,
      station: json['station'] as String,
      content: json['content'] as String,
    );
  }
}
