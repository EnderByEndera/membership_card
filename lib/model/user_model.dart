import 'package:flutter/cupertino.dart';
import 'package:membership_card/pages/login.dart';
import 'card_count.dart';
import 'dart:convert';

/// This is the User Model for [LoginPage] to use.
/// When the user wants to login or register, it may use this [User] Model.
/// Usage:
/// ```dart
/// User user = User(username, password);
/// ```
/// Notice that [_username] and [_password] is not necessary to create one User.
class User extends ChangeNotifier {
  static const String _ID_JSON = "Id";
  static const String _Mail_JSON = "Mail";
  static const String _PASSWORD_JSON = "Password";
  static const String _TEL_JSON = "Tel";
  static const String _LOGINMONTH_JSON = "LoginMonth";
  static const String _LOGINNUM_JSON = "LoginNum";
  static const String _LOGINYEAR_JSON = "LoginYear";

  String _userId;
  String _password;
  String _mail;
  String _tel;
  String _loginMonth;
  int _loginNum;
  String _loginYear;


  String get userId => _userId;
  String get password => _password;
  String get mail => _mail;
  String get tel => _tel;
  String get loginMonth => _loginMonth;
  int get loginNum => _loginNum;
  String get loginYear => _loginYear;



  User([this._userId, this._password]);

  set userId(String value) {
    _userId = value;
  }
  set password(String value) {
    _password = value;
  }
  set mail(String value) {
    _mail = value;
  }
  set tel(String value) {
    _tel = value;
  }

  User.fromJson(Map<String, dynamic> json) {
    _userId = json[_ID_JSON];
    _password = json[_PASSWORD_JSON];
    _mail = json[_Mail_JSON];
    _tel = json[_TEL_JSON];
    _loginMonth = json[_LOGINMONTH_JSON];
    _loginNum = json[_LOGINNUM_JSON];
    _loginYear = json[_LOGINYEAR_JSON];
  }

  Map<String, dynamic> toJson() {
    var user = <String, dynamic>{
      _ID_JSON: _userId,
      _PASSWORD_JSON: _password,
      _Mail_JSON: _mail,
    };
    return user;
  }

}
