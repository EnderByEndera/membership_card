import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:membership_card/model/user_model.dart';
import 'package:membership_card/network/client.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChangePasswordPageState();
  }
}

class ChangePasswordPageState extends State<ChangePasswordPage>{
  var _newPasswordController=TextEditingController();
  var _verifyNewPasswordController=TextEditingController();
  bool _rePasswordCorrect = false;
  bool _passwordCorrect = false;
  bool isSent = false;
  String _passwordErrMsg;
  String _rePasswordErrMsg;
  String _prePassword;
  String _changePassMsg;


  var dio = initDio();
  Response res;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _verifyNewPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    _newPasswordController.addListener(() {
      if (_newPasswordController.text.contains(RegExp(r"\W"))) {
        setState(() {
          _passwordCorrect = false;
          _passwordErrMsg = "You Can only input 0-9, a-z and A-Z";
        });
      } else if (_newPasswordController.text.isEmpty) {
        setState(() {
          _passwordCorrect = false;
          _passwordErrMsg = "New Password can not be empty";
        });
      } else if (_newPasswordController.text.length <= 6) {
        setState(() {
          _passwordCorrect = false;
          _passwordErrMsg = "New Password is too short";
        });

      }else if(_newPasswordController.text==_prePassword){
        _passwordCorrect = false;
        _passwordErrMsg = "New Password Should Be Different With The Previous One";
      }else {
        setState(() {
          _passwordCorrect = true;
          _passwordErrMsg = null;
        });
      }
    });
    _verifyNewPasswordController.addListener(() {
       if(_verifyNewPasswordController.text!=_newPasswordController.text){
        setState(() {
          _rePasswordCorrect=false;
          _rePasswordErrMsg="The Password Entered Are Different";
        });
      }else {
        setState(() {
          _rePasswordCorrect = true;
          _rePasswordErrMsg = null;
        });
      }
    });
  }

  @override

  Widget build(BuildContext context) {
  var newPasswordTextField = TextFormField(
    obscureText: true,
    decoration: InputDecoration(
    labelText: "Please Input New Password",
    errorText: _passwordErrMsg,
    contentPadding: EdgeInsets.all(10.0),
      icon: Icon(Icons.edit),
  ),
    keyboardType: TextInputType.text,
    controller: _newPasswordController,
    maxLength: 24,
  );

  var verifyPasswordTextField = TextFormField(
    obscureText: true,
    decoration: InputDecoration(
      labelText: "Please Input New Password",
      errorText: _rePasswordErrMsg,
      contentPadding: EdgeInsets.all(10.0),
      icon: Icon(Icons.edit),
    ),
    keyboardType: TextInputType.text,
    controller: _verifyNewPasswordController,
    maxLength: 24,
  );

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Container(
            child: GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Text(
                  "< Back",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 25.0,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),


          actions: <Widget>[
            Consumer<User>(
             builder: (context, user, child) => FlatButton(
               //require connection
              onPressed: _rePasswordCorrect&&_passwordCorrect?() async{
                _changePassMsg = "";
                setState(() {
                  isSent = true;
                });
                //new password
                user.password = _newPasswordController.text;
                res = await dioChangePass(dio, user);
                setState(() {
                  isSent = false;
                });
                if (res.statusCode == 200) {
                  try {
                    Map<String, dynamic> json =
                    jsonDecode(res.data);
                    if (json["changeInfo"] == "success") {
                      Navigator.pop(context);
                      _changePassMsg = "successfully changed!";
                      showDialog(
                          context: context,
                          builder: (_) =>
                              AlertDialog(
                                title: Text("Alert"),
                                content: Text(_changePassMsg),
                              ));
                    } else {
                      _changePassMsg = "Change Failed!";
                      showDialog(
                          context: context,
                          builder: (_) =>
                              AlertDialog(
                                title: Text("Alert"),
                                content: Text(_changePassMsg),
                              ));
                    }
                  } on FormatException {
                    _changePassMsg = "Login Failed";
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text("Alert"),
                          content: Text(_changePassMsg),
                        ));
                  }
                }else if (res.statusCode == 400 ||
                    res.statusCode == 404){
                  _changePassMsg=
                  "Network connection failed, "
                      "check your network";
                  showDialog(context: context, builder: (_) => AlertDialog(
                    title: Text("Alert"),
                    content: Text(_changePassMsg),
                  ));
                }
              } : null ,
              child: Text(
                'Save',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 25.0,),
              ),
            ),
            )
          ],
        )

    );
  }
}

//进度条
//Container(
//child: isSent
//? CircularProgressIndicator()
//    : Text(
//_loginMsg == null ? "" : _loginMsg,
//textAlign: TextAlign.center,
//),
//),