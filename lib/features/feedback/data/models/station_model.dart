class StationModel {
  final String id;
  final String name;

  StationModel({required this.id, required this.name});

  factory StationModel.fromJson(Map<String, dynamic> json) {
    return StationModel(id: json['id'] as String, name: json['name'] as String);
  }
}
