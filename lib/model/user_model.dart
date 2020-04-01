import 'package:flutter/cupertino.dart';
import 'package:membership_card/pages/login.dart';
import 'card_count.dart';
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
  static const String _CARDCOUNT_JSON = "cardcount";

  String _username;
  String _password;
  CardCounter _cardcount;
  String get username => _username;
  String get password => _password;
  CardCounter get cardcount => _cardcount;

  User([this._username, this._password]);

  set username(String value) {
    _username = value;
  }

  User.fromJson(Map<String, dynamic> json) {
    _username = json[_USERNAME_JSON];
    _password = json[_PASSWORD_JSON];
    _cardcount = json[_CARDCOUNT_JSON];
  }

  Map<String, dynamic> toJson() {
    var user = <String, dynamic>{
      _USERNAME_JSON: _username,
      _PASSWORD_JSON: _password,
      _CARDCOUNT_JSON: _cardcount,
    };
    return user;
  }

  set password(String value) {
    _password = value;
  }
}
