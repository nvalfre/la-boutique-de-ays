import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  static AuthProvider _instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthProvider._internal();

  static AuthProvider getState() {
    if (_instance == null) {
      _instance = AuthProvider._internal();
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

  Future<UserCredential> logInGuest() async => await _auth.signInAnonymously();

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
