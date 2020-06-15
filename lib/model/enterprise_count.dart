import 'package:flutter/cupertino.dart';
import 'package:membership_card/model/enterprise_model.dart';

class EnterpriseCounter extends ChangeNotifier {
  static const String ENTERPRISES_JSON = "enterprise";

  List<EnterpriseInfo> _enterpriseList = new List<EnterpriseInfo>();

  EnterpriseCounter(this._enterpriseList);

  set enterpriseList(List<EnterpriseInfo> value) {
    _enterpriseList = value;
  } //default constructor

  List<EnterpriseInfo> get enterpriseList => _enterpriseList;
}