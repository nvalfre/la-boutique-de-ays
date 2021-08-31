import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../providers/authentication_provider.dart';
import '../validators/email_validator.dart';
import '../validators/name_validator.dart';
import '../validators/password_validator.dart';

import 'package:rxdart/rxdart.dart';

class AuthBloc with PasswordValidator, EmailValidator, NameValidator {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _nameController = BehaviorSubject<String>();

  final _loadingController = new BehaviorSubject<bool>();

  //TODO Migrate to service
  final _authProvider = AuthProvider.getState();

  //final _userServiceImpl = UserServiceImpl.getState();
  //final _prefs = new UserPreferences();

  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmailRegEx);

  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePasswordLenght);

  Stream<String> get nameStream =>
      _nameController.stream.transform(validateNameLenght);

  //Stream<String> get lastNameStream =>
  //    _lastNameController.stream.transform(validateNameLenght);
//
  //Stream<String> get telephoneStream =>
  //    _telephoneController.stream.transform(validateTelRegEx);
//
  //Stream<String> get directionStream =>
  //    _directionController.stream.transform(validateDirectionLength);

  Stream<bool> get isValidFormStreamLogin =>
      Observable.combineLatest2(emailStream, passwordStream, (e, p) => true);

// Stream<bool> get isValidFormStreamRegister => Observable.combineLatest6(
//     emailStream,
//     passwordStream,
//     nameStream,
//     lastNameStream,
//     telephoneStream,
//     directionStream,
//     (e, p, n, ln, t, d) => true);

  Function(String) get changeEmail => _emailController.sink.add;

  Function(String) get changePassword => _passwordController.sink.add;

  Function(String) get changeName => _nameController.sink.add;

  // Function(String) get changeLastName => _lastNameController.sink.add;
//
  // Function(String) get changeTelephone => _telephoneController.sink.add;
//
  // Function(String) get changeDirection => _directionController.sink.add;

  String get email => _emailController.value;

  String get password => _passwordController.value;

  String get name => _nameController.value;

  //String get lastName => _lastNameController.value;

  //String get telephone => _telephoneController.value;

  //String get direction => _directionController.value;

  Future<UserCredential> logIn(String email, String password) async {
    UserCredential firebaseUser = await _authProvider.logIn(email, password);
    return firebaseUser;
  }

  Future<void> logOut() async {
    return await _authProvider.signOut();
  }

  Future<UserCredential> registerFirebase(String email, String password) async {
    return await _authProvider.registerFirebase(email, password);
  }

  Future<void> handleUserRegister(UserCredential authResult, File image,
      String username, String email) async {
    // await _userServiceImpl.createUserData(
    //     info, email, name, lastName, telephone, direction);
    await addUser(authResult, image, username, email);

  }

  Future<void> addUser(UserCredential authResult, File image, String username,
      String email) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child(authResult.user.uid + '.jpg');

    await ref.putFile(image);

    final url = await ref.getDownloadURL();
    final usersCollection = FirebaseFirestore.instance.collection('users');
    var newUser = {
      authResult.user.uid: {
        'username': username,
        'email': email,
        'image_url': url,
      }
    };
    await usersCollection.add(newUser);
  }

  dispose() {
    _emailController?.close();
    _passwordController?.close();
    _nameController?.close();
    // _lastNameController?.close();
    // _telephoneController?.close();
    // _directionController?.close();
    _loadingController?.close();
  }
}
