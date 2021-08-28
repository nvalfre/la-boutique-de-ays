import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  static AuthenticationService _instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthenticationService._internal();

  static AuthenticationService getState() {
    if (_instance == null) {
      _instance = AuthenticationService._internal();
    }

    return _instance;
  }

  Future<UserCredential> logIn(String email, String password) async {
    UserCredential firebaseUser = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return firebaseUser;
  }

  Future<UserCredential> registerFirebase(String email, String password) async {
    UserCredential createUserWithEmailAndPassword = await _auth
        .createUserWithEmailAndPassword(email: email, password: password);
    return createUserWithEmailAndPassword;
  }

  User getCurrentUser() {
    return _auth.currentUser;
  }

  Future<void> signOut() async {
    return _auth.signOut();
  }

  Future<void> sendEmailVerification() async {
    _auth.currentUser.sendEmailVerification();
  }

  bool isEmailVerified() {
    return _auth.currentUser.emailVerified;
  }

  bool isAnonymous() {
    return _auth.currentUser.isAnonymous;
  }
}
