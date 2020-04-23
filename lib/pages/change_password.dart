import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:membership_card/model/card_count.dart';
import 'package:membership_card/model/user_model.dart';
import 'package:membership_card/network/client.dart';
import 'package:provider/provider.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:membership_card/network/cookie.dart';
class ChangePasswordPage extends StatefulWidget {
  User user;
  ChangePasswordPage(this.user);
  @override
  State<StatefulWidget> createState() {
    return ChangePasswordPageState(this.user);
  }
}

class ChangePasswordPageState extends State<ChangePasswordPage>{
  User user;
  ChangePasswordPageState(this.user);


  var _newPasswordController=TextEditingController();
  var _verifyNewPasswordController=TextEditingController();
  var _oldPasswordController=TextEditingController();

  bool _rePasswordCorrect = false;
  bool _passwordCorrect = false;
  bool _oldPasswordCorrect = false;

  bool isSent = false;
  String _passwordErrMsg;
  String _rePasswordErrMsg;
  String _oldPasswordErrMsg;


  String _prePassword;
 String _userId1;

  String _changePassMsg;


  var dio = initDio();
  Response res;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _verifyNewPasswordController.dispose();
    _oldPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();

    _userId1=user.userId;
    _prePassword=user.password;

    _oldPasswordController.addListener((){
      if(_oldPasswordController.text!=_prePassword){
        setState(() {
          _oldPasswordCorrect=false;
          _oldPasswordErrMsg="Please Input The Correct Old Password";
        });
      }else{
        _oldPasswordCorrect=true;
        _oldPasswordErrMsg=null;
      }

    }
    );

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
  GlobalKey _formKey = GlobalKey<FormState>();


  @override

  Widget build(BuildContext context) {

  dynamic args=ModalRoute.of(context).settings.arguments;
  print(_prePassword);

  var _newPasswordTextField = TextFormField(
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

  var _verifyPasswordTextField = TextFormField(
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

  var _oldPasswordTextField = TextFormField(
    obscureText: true,
    decoration: InputDecoration(
      labelText: "Please Input Old Password",
      errorText: _oldPasswordErrMsg,
      contentPadding: EdgeInsets.all(10.0),
      icon: Icon(Icons.edit),
    ),
    keyboardType: TextInputType.text,
    controller: _oldPasswordController,
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
             FlatButton(
               //require connection
              onPressed: (_rePasswordCorrect&&_passwordCorrect&&_oldPasswordCorrect)?() async{
                _changePassMsg = "";

                dio.interceptors.add(CookieManager(CookieJar()));

                setState(() {
                  isSent = true;
                });
                dio.interceptors.add(CookieManager(await Api.cookieJar));
                //new password
                res = await dioChangePass(dio, user.userId, _prePassword,_newPasswordController.text);

                setState(() {
                  isSent = false;
                });
                if (res.statusCode == 200) {
                  try {
                    print(res.statusCode);
                     user.password = _newPasswordController.text;
                      Navigator.pop(context);
                      _changePassMsg = "successfully changed!";
                      showDialog(
                          context: context,
                          builder: (_) =>
                              AlertDialog(
                                title: Text("Alert"),
                                content: Text(_changePassMsg),
                              ));

                  } on FormatException {
                    _changePassMsg = "Change Failed";
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text("Alert"),
                          content: Text(_changePassMsg),
                        ));
                  }
                }else if (res.statusCode == 400 ||
                    res.statusCode == 404) {
                  try {
                    print(res.statusCode);
                    _changePassMsg =
                    "Network connection failed, "
                        "check your network";
                    showDialog(context: context, builder: (_) =>
                        AlertDialog(
                          title: Text("Alert"),
                          content: Text(_changePassMsg),
                        ));
                  }on FormatException {
                    _changePassMsg = "Change Failed";
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text("Alert"),
                          content: Text(_changePassMsg),
                        ));
                  }
                }else{
                  try{
                    print(res.statusCode);
                   print(user.userId);
                    print(_prePassword);
                    _changePassMsg = "Failed to Change";
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text("Alert"),
                          content: Text(_changePassMsg),
                        ));
                  }on FormatException {
                    _changePassMsg = "Change Failed";
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text("Alert"),
                          content: Text(_changePassMsg),
                        ));
                  }
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

          ],
        ),


       body: GestureDetector(
         behavior: HitTestBehavior.translucent,
         onTap: () {
           FocusScope.of(context).requestFocus(FocusNode());
         },
         child: ListView(
           children: <Widget>[
             Form(
               key: _formKey,
               autovalidate: true,
               child: Column(
                 children: <Widget>[
                   Text("Change Your Password",textAlign: TextAlign.center,maxLines: 1,style:
                   TextStyle(
                       color: Colors.orange
                   ),),


                   _oldPasswordTextField,
                   _newPasswordTextField,
                   _verifyPasswordTextField,

                   //进度条
                   Container(
                     child: isSent
                         ? CircularProgressIndicator()
                         : Text(
                       _changePassMsg == null ? "" : _changePassMsg,
                       textAlign: TextAlign.center,
                     ),
                   ),
                 ],
               ),

             ),
           ],
         ),
    ),

    );
  }
}

