import 'package:flutter/cupertino.dart';
import 'package:membership_card/model/enterprise_model.dart';

class EnterpriseCounter extends ChangeNotifier {
  static const String ENTERPRISES_JSON = "enterprise";

  List<EnterpriseInfo> _enterpriseList = new List<EnterpriseInfo>();

  EnterpriseCounter(this._enterpriseList);

  set enterpriseList(List<EnterpriseInfo> value) {
    _enterpriseList = value;
    notifyListeners();
  } //default constructor

  List<EnterpriseInfo> get enterpriseList => _enterpriseList;

  EnterpriseCounter.fromJson(Map<String, dynamic> json){
    List<dynamic> list = json[ENTERPRISES_JSON];
    for (int i = 0; i < list.length; i++) {
      _enterpriseList.add(
          EnterpriseInfo.fromCOUNTER(
              list[i].Id,
              list[i].Addr,
              list[i].IsLocal,
              list[i].Type,
              list[i].RegisterNum,
              list[i].Name,
              list[i].HelpMsg,
              list[i].Website,
              list[i].LicenseId));
    }
  }
}