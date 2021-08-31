import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

User newUser(String id, String email, String name, String userStatus,
    String userRole, String avatar) => User.newUser(id, email, name, userStatus, userRole, avatar);
User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.email,
    this.name,
    this.userStatus,
    this.userRole,
    this.avatar,
  });

  String id;
  String email;
  String name;
  String userStatus;
  String userRole;
  String avatar;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        userStatus: json["user_status"],
        userRole: json["user_role"],
        avatar: json["avatar"],
      );

  factory User.newUser(String id, String email, String name, String userStatus,
          String userRole, String avatar) =>
      User(
        id: id,
        email: email,
        name: name,
        userStatus: userStatus,
        userRole: userRole,
        avatar: avatar,
      );

  factory User.fromQuerySnapshot(QuerySnapshot snap) {
    var document = snap.docs[0];
    return User(
      id:  document.data()["id"],
      email:  document.data()['email'],
      name:  document.data()['name'],
      userStatus:  document.data()['userStatus'],
      userRole:  document.data()['userRole'],
      avatar:  document.data()['avatar'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "user_status": userStatus,
    "user_role": userRole,
    "avatar": avatar,
  };
}
