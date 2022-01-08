// To parse this JSON data, do
//
//     final organization = organizationFromJson(jsonString);

import 'dart:convert';

List<Organization> organizationFromJson(String str) => List<Organization>.from(
    json.decode(str).map((x) => Organization.fromJson(x)));

String organizationToJson(List<Organization> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Organization OrganizationFromJson(String str) =>
    Organization.fromJson(json.decode(str));

String OrganizationToJson(Organization data) => json.encode(data.toJson());

class Organization {
  Organization({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.phonenum,
    required this.email,
    required this.hooName,
    required this.discription,
    required this.username,
    required this.password,
    required this.status,
  });

  int id;
  String name;
  String address;
  String city;
  String phonenum;
  String email;
  String hooName;
  String discription;
  String username;
  String password;
  String status;

  factory Organization.fromJson(Map<String, dynamic> json) => Organization(
        id: json["id"],
        name: json["Name"],
        address: json["Address"],
        city: json["City"],
        phonenum: json["Phonenum"],
        email: json["Email"],
        hooName: json["HooName"],
        discription: json["Discription"],
        username: json["Username"],
        password: json["Password"],
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Name": name,
        "Address": address,
        "City": city,
        "Phonenum": phonenum,
        "Email": email,
        "HooName": hooName,
        "Discription": discription,
        "Username": username,
        "Password": password,
        "Status": status,
      };
}
