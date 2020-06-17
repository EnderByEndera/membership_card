import 'package:flutter/cupertino.dart';
import 'package:membership_card/model/activity_model.dart';
import 'package:membership_card/model/enterprise_model.dart';

class ActivityCounter extends ChangeNotifier {
//  static const String ACTIVITY_JSON = "";

  List<ActivityInfo> _activityList = new List<ActivityInfo>();

  set activityList(List<ActivityInfo> value) {
    _activityList = value;
    notifyListeners();
  }
  ActivityInfo getOneActivity(int index) {
    return _activityList.elementAt(index);
  }
  ActivityCounter(this._activityList);
  List<ActivityInfo> get activityList => _activityList;
  ActivityCounter.fromJson(List<dynamic> json){
    List<ActivityInfo> list = [];
    for (int i = 0; i < json.length; i++) {
      list.add(ActivityInfo.fromJson(json[i]));
    }
    _activityList = list;
  }
}
