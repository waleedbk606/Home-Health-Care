// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.uid,
    required this.fname,
    required this.lname,
    required this.dob,
    required this.gender,
    required this.email,
    required this.phone,
    required this.username,
    required this.password,
  });

  int uid;
  String fname;
  String lname;
  String dob;
  String gender;
  String email;
  String phone;
  String username;
  String password;

  factory User.fromJson(Map<String, dynamic> json) => User(
        uid: json["Uid"],
        fname: json["Fname"],
        lname: json["Lname"],
        dob: json["DOB"],
        gender: json["Gender"],
        email: json["Email"],
        phone: json["Phone"],
        username: json["Username"],
        password: json["Password"],
      );

  Map<String, dynamic> toJson() => {
        "Uid": uid,
        "Fname": fname,
        "Lname": lname,
        "DOB": dob,
        "Gender": gender,
        "Email": email,
        "Phone": phone,
        "Username": username,
        "Password": password,
      };
}
