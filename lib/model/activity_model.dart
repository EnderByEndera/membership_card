import 'package:flutter/cupertino.dart';

class ActivityInfo extends ChangeNotifier {
  static const String ID_JSON = "Id";
  static const String TYPE_JSON = "CardType";
  static const String ENTERPRISE_JSON = "Enterprise";
  static const String STATE_JSON = "State";
  static const String CITY_JSON = "City";
  static const String COUPONS_JSON = "Coupons";
  static const String DESCRIPTION_JSON = "Describe";
  static const String EXPIRETIME_JSON = "ExpireTime";

  String _activityId;
  String _type;
  String _enterprise;
  String _state;
  String _city;
  String _coupons;
  String _description;
  String _expireTime;


  String get activityId => _activityId;
  String get type => _type;
  String get enterprise => _enterprise;
  String get state => _state;
  String get city => _city;
  String get coupons => _coupons;
  String get description => _description;
  String get expireTime => _expireTime;

  ActivityInfo([this._activityId, this._type, this._enterprise]);

  set activityId(String value) {
    _activityId = value;
  }
  set type(String value) {
    _type = value;
  }
  set enterprise(String value) {
    _enterprise = value;
  }
  set state(String value) {
    _state = value;
  }
  set city(String value){
    _city = value;
  }
  set coupons(String value){
    _coupons = value;
  }
  set description(String value){
    _description = value;
  }
  set expireTime(String value){
    _description = value;
  }

  ActivityInfo.fromJson(Map<String, dynamic> json) {
    _activityId = json[ID_JSON];
    _type = json[TYPE_JSON];
    _enterprise = json[ENTERPRISE_JSON];
    _state = json[STATE_JSON];
    _city = json[CITY_JSON];
    _coupons = json[COUPONS_JSON];
    _description = json[DESCRIPTION_JSON];
    _expireTime = json[EXPIRETIME_JSON];
  }

}
