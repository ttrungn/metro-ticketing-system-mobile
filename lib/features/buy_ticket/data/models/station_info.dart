class StationInfo {
  String id;
  String name;

  StationInfo({required this.id, required this.name});

  factory StationInfo.fromJson(Map<String, dynamic> json) {
    return StationInfo(id: json['id'], name: json['name']);
  }
}
