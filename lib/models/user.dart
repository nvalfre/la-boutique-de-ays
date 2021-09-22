import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel newUser(String id, String email, String name, String userStatus,
    String userRole, String imageUrl, phoneNumber, joinedAt, Timestamp createdAt) => UserModel.newUser(id, email, name, userStatus, userRole, imageUrl, phoneNumber, joinedAt, createdAt);
UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));
String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.id,
    this.email,
    this.name,
    this.userStatus,
    this.userRole,
    this.imageUrl,
    this.phoneNumber,
    this.joinedAt,
    this.createdAt,
  });

  String id;
  String email;
  String name;
  String userStatus;
  String userRole;
  String imageUrl;
  String phoneNumber;
  String joinedAt;
  Timestamp createdAt;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    email: json["email"],
    name: json["name"],
    userStatus: json["user_status"],
    userRole: json["user_role"],
    imageUrl: json["image_url"],
    phoneNumber: json["phone_number"],
    joinedAt: json["joined_at"],
    createdAt: json["created_at"],
  );

  factory UserModel.newUser(String id, String email, String name, String userStatus,
      String userRole, String imageUrl, String phoneNumber, String joinedAt, Timestamp createdAt) =>
      UserModel(
        id: id,
        email: email,
        name: name,
        userStatus: userStatus,
        userRole: userRole,
        imageUrl: imageUrl,
        phoneNumber: phoneNumber,
        joinedAt: joinedAt,
        createdAt: createdAt,
      );

  factory UserModel.fromQuerySnapshot(QuerySnapshot snap) {
    var document = snap.docs[0];
    return UserModel(
      id:  document.data()["id"],
      email:  document.data()['email'],
      name:  document.data()['name'],
      userStatus:  document.data()['user_status'],
      userRole:  document.data()['user_role'],
      imageUrl:  document.data()['image_url'],
      phoneNumber:  document.data()['phone_number'],
      joinedAt:  document.data()['joined_at'],
      createdAt:  document.data()['created_at'],
    );
  }

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot document) {
    return UserModel(
      id:  document.data()["id"],
      email:  document.data()['email'],
      name:  document.data()['name'],
      userStatus:  document.data()['user_status'],
      userRole:  document.data()['user_role'],
      imageUrl:  document.data()['image_url'],
      phoneNumber:  document.data()['phone_number'],
      joinedAt:  document.data()['joined_at'],
      createdAt:  document.data()['created_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "user_status": userStatus,
    "user_role": userRole,
    "image_url": imageUrl,
    "phone_number": imageUrl,
    "joined_at": joinedAt,
    "created_at": createdAt,
  };
}
