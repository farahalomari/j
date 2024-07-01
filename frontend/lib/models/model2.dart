class Route{
  final int routeID;
  final String routeName;

  const Route({
    required this.routeID,
    required this.routeName,
  });
  factory Route.fromJson(Map<String,dynamic> json) => Route(
    routeID: json['routeID'],
    routeName: json['routeName'],
  );
  Map<String,dynamic> toJson()=>{
    "routeID":routeID,
    "routeName":routeName,
  };
}