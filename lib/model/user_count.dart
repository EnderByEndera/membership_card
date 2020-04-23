import 'package:flutter/material.dart';
import 'package:membership_card/model/user_model.dart';

class UserCounter extends ChangeNotifier {
  var _userList = List<User>();
  set userList(List<User> cardList) => this._userList = cardList;
  List<User> get userList => _userList;

  void addUser(User user) {
    _userList.add(user);
    notifyListeners();
  }

}
