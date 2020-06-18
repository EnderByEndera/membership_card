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
      Map<String, dynamic> data = list[i];
      _enterpriseList.add(
          EnterpriseInfo.fromCOUNTER(
              data["ID"],
              data["Addr"],
              data["IsLocal"],
              data["Type"],
              data["RegisterNum"],
              data["Name"],
              data["HelpMsg"],
              data["Website"],
              data["LicenseId"]));
    }
  }
}
