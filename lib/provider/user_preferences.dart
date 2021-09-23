import 'dart:convert';

import 'package:la_boutique_de_a_y_s_app/models/enum/user_role.dart';
import 'package:la_boutique_de_a_y_s_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = new UserPreferences._internal();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();

  SharedPreferences _prefs;

  initUserPreferences() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // Getters
  get user {
    return _prefs.getString('uuid') ?? '';
  }

  get userRole {
    return _prefs.getString('userRole') ?? '';
  }

  get imageUrl {
    return _prefs.getString('imageUrl') ?? '';
  }

  get lastProduct {
    return _prefs.getString('lastProduct') ?? '';
  }

  get lastPage {
    return _prefs.getString('lastPage') ?? 'splash';
  }

  get isAdmin {
    return _prefs.getBool('isAdmin') ?? false;
  }

  // Setters
  set user(String value) {
    _prefs.setString('user', value);
  }

  set userRole(String value) {
    _prefs.setString('userRole', value);
  }

  set imageUrl(String value) {
    _prefs.setString('imageUrl', value);
  }

  set lastPage(String value) {
    _prefs.setString('lastPage', value);
  }

  set lastProduct(String value) {
    _prefs.setString('lastProduct', value);
  }

  set isAdmin(bool value) {
    _prefs.setBool('isAdmin', value);
  }

  void saveMap(String key, Map<String, dynamic> inputMap) {
    String encodedMap = json.encode(inputMap);
    print(encodedMap);

    _prefs.setString(key, encodedMap);
  }

  Map<String, dynamic> loadMap(String key) {
    String encodedMap = _prefs.getString(key);
    Map<String, dynamic> decodedMap = json.decode(encodedMap);
    return decodedMap;
  }

  bool isLoadedAdmin() =>
      this.userRole == UserRole.ADMIN.toString() && this.isAdmin;

  void clear() {
    _prefs.setString('uuid', '');
    _prefs.setString('userRole', '');
    _prefs.setString('avatar', '');
    _prefs.setString('lastPage', '');
    _prefs.setString('lastProduct', '');
  }

  void loadUser(UserModel userModel) {
    this.user = userModel.id;
    this.userRole = userModel.userRole;
    this.imageUrl = userModel.imageUrl;
    this._loadAdmin();
  }

  void _loadAdmin() {
    if (this.userRole == UserRole.ADMIN.toString()) {
      this.isAdmin = true;
    }
  }
}
