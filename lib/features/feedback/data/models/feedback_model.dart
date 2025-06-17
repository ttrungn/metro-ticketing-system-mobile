class FeedbackModel {
  final String type;
  final String location;
  final String content;

  FeedbackModel({
    required this.type,
    required this.location,
    required this.content,
  });

  // factory FeedbackModel.fromJson(Map<String, dynamic> json) {
  //   return FeedbackModel(
  //     type: json['type'] as String,
  //     location: json['location'] as String,
  //     content: json['content'] as String,
  //   );
  // }
}
