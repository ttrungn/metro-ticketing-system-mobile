class FeedbackType {
  final String id;
  final String name;

  FeedbackType({required this.id, required this.name});

  factory FeedbackType.fromJson(Map<String, dynamic> json) {
    return FeedbackType(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }
}