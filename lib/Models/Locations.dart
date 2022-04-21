// To parse this JSON data, do
//
//     final locations = locationsFromJson(jsonString);

import 'dart:convert';

List<Locations> locationsFromJson(String str) =>
    List<Locations>.from(json.decode(str).map((x) => Locations.fromJson(x)));

String locationsToJson(List<Locations> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Locations {
  Locations({
    required this.id,
    required this.orgName,
    required this.lat,
    required this.long,
    required this.radius,
  });

  int id;
  String orgName;
  String lat;
  String long;
  String radius;

  factory Locations.fromJson(Map<String, dynamic> json) => Locations(
        id: json["id"],
        orgName: json["OrgName"],
        lat: json["Lat"],
        long: json["Long"],
        radius: json["Radius"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "OrgName": orgName,
        "Lat": lat,
        "Long": long,
        "Radius": radius,
      };
}
