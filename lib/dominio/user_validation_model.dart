// To parse this JSON data, do
//
//     final userValidation = userValidationFromJson(jsonString);

import 'dart:convert';

UserValidation userValidationFromJson(String str) => UserValidation.fromJson(json.decode(str));

String userValidationToJson(UserValidation data) => json.encode(data.toJson());

class UserValidation {
    UserValidation({
        this.username,
        this.phone,
    });

    String username;
    String phone;

    factory UserValidation.fromJson(Map<String, dynamic> json) => UserValidation(
        username: json["username"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "phone": phone,
    };
}
