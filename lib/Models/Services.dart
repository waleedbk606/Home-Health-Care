// To parse this JSON data, do
//
//     final services = servicesFromJson(jsonString);

import 'dart:convert';

List<Services> servicesFromJson(String str) =>
    List<Services>.from(json.decode(str).map((x) => Services.fromJson(x)));

String servicesToJson(List<Services> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Services {
  Services({
    required this.id,
    required this.name,
    required this.discription,
    required this.staff,
    required this.charges,
    required this.organization,
  });

  int id;
  String name;
  String discription;
  String staff;
  String charges;
  String organization;

  factory Services.fromJson(Map<String, dynamic> json) => Services(
        id: json["id"],
        name: json["Name"],
        discription: json["Discription"],
        staff: json["Staff"],
        charges: json["Charges"],
        organization: json["Organization"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Name": name,
        "Discription": discription,
        "Staff": staff,
        "Charges": charges,
        "Organization": organization,
      };
}
