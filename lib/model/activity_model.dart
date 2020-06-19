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
  //static const String TYPE_ID_JSON     = "TypeId";
//  static const String BASE64_JSON="BackgroundBase64";

  int _Id;
  String _type;
  String _enterprise;
  String _state;
  String _city;
  String _coupons;
  String _description;
  String _expireTime;
//  String _backgroundbase64;


  int get Id => _Id;
  String get type => _type;
  String get enterprise => _enterprise;
  String get state => _state;
  String get city => _city;
  String get coupons => _coupons;
  String get description => _description;
  String get expireTime => _expireTime;
//  String get backgroundbase64=> _backgroundbase64;

  set Id(int value) {
    _Id = value;
  }

  ActivityInfo([this._Id, this._type, this._enterprise]);
//  set backgroundbase64(String value){
//    _backgroundbase64=value;
//    notifyListeners();
//  }

  set activityId(int value) {
    _Id = value;
    notifyListeners();
  }
  set type(String value) {
    _type = value;
    notifyListeners();
  }
  set enterprise(String value) {
    _enterprise = value;
    notifyListeners();
  }
  set state(String value) {
    _state = value;
    notifyListeners();
  }
  set city(String value){
    _city = value;
    notifyListeners();
  }
  set coupons(String value){
    _coupons = value;
    notifyListeners();
  }
  set description(String value){
    _description = value;
    notifyListeners();
  }
  set expireTime(String value){
    _description = value;
    notifyListeners();
  }

  ActivityInfo.fromJson(Map<String, dynamic> json) {
    _Id = json[ID_JSON];
    _type = json[TYPE_JSON];
    _enterprise = json[ENTERPRISE_JSON];
    _state = json[STATE_JSON];
    _city = json[CITY_JSON];
    _coupons = json[COUPONS_JSON];
    _description = json[DESCRIPTION_JSON];
    _expireTime = json[EXPIRETIME_JSON];
    //this._typeId = json[TYPE_ID_JSON];
//    _backgroundbase64=json[BASE64_JSON];

  }
}
