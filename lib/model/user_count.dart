import 'package:flutter/material.dart';
import 'package:membership_card/model/user_model.dart';

class UserCounter extends ChangeNotifier {
  List<User> _userList;
  int length;

  UserCounter(){
    _userList = new List<User>();
    length = 0;
  }

  set userList(List<User> cardList){
    this._userList = cardList;
    notifyListeners();
  }
  List<User> get userList => _userList;

  void addUser(User user) {
    _userList.add(user);
    length++;
    notifyListeners();
  }

  User index(int i){
    return _userList[i];
  }

  void remove(User user) {
    int i;
    for (i = 0; i < length; i++) {
      if (_userList[i].lastLoginAccount == user.lastLoginAccount)
        break;
    }
    if (i != length) {
      _userList.removeAt(i);
      length--;
    }
  }

  List<User> getList(){
    return _userList;
  }

  void clear(){
    _userList.clear();
  }
}
