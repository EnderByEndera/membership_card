import 'package:flutter/cupertino.dart';
import 'package:membership_card/pages/login.dart';

/// This is the User Model for [LoginPage] to use.
/// When the user wants to login or register, it may use this [User] Model.
/// Usage:
/// ```dart
/// User user = User(username, password);
/// ```
/// Notice that [_username] and [_password] is not necessary to create one User.
class User extends ChangeNotifier {
  static const String _USERNAME_JSON = "username";
  static const String _PASSWORD_JSON = "password";

  String _username;
  String _password;

  String get username => _username;

  String get password => _password;

  User([this._username, this._password]);

  User.fromJson(Map<String, dynamic> json) {
    _username = json[_USERNAME_JSON];
    _password = json[_PASSWORD_JSON];
  }

  Map<String, dynamic> toJson() {
    var user = <String, dynamic>{
      _USERNAME_JSON: _username,
      _PASSWORD_JSON: _password,
    };
    return user;
  }
}
