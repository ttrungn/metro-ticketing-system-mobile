

class RouteInfo{
  String id;
  String name;

  RouteInfo({required this.id,required this.name});


  factory RouteInfo.fromJson(Map<String,dynamic> json){
    return RouteInfo(
      id: json['id'],
      name: json['name'],
    );
  }
}