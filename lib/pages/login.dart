import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:membership_card/model/user_model.dart';
import 'package:membership_card/network/client.dart';
import 'package:provider/provider.dart';
import 'package:membership_card/model/card_model.dart';
import 'package:membership_card/model/card_count.dart';
import 'package:membership_card/model/user_count.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  var _passwordController = TextEditingController();
  var _accountController = TextEditingController();

  bool isSent = false;
  bool _accountCorrect = false;
  bool _passwordCorrect = false;
  String _loginMsg;
  String _accountErrMsg;
  String _passwordErrMsg;
  bool _remember = false;
  bool isTel;
  bool isMail;

  var dio = initDio();
  Response res1;
  Response res2;

  @override
  void dispose() {
    _passwordController.dispose();
    _accountController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      if (_passwordController.text.contains(RegExp(r"\W"))) {
        setState(() {
          _passwordCorrect = false;
          _passwordErrMsg = "Can only input 0-9, a-z and A-Z";
        });
      } else if (_passwordController.text.isEmpty) {
        setState(() {
          _passwordCorrect = false;
          _passwordErrMsg = "Password can not be empty";
        });
      } else if (_passwordController.text.length <= 6) {
        setState(() {
          _passwordCorrect = false;
          _passwordErrMsg = "Password is too short";
        });
      } else {
        setState(() {
          _passwordCorrect = true;
          _passwordErrMsg = null;
        });
      }
    });
    _accountController.addListener(() {
      RegExp exp1 = RegExp(
          r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
      isTel = exp1.hasMatch(_accountController.text);     //校验手机号
      RegExp exp2 = RegExp(
        "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$"
      );
      isMail = exp2.hasMatch(_accountController.text);    //校验邮箱

      if (_accountController.text.isEmpty) {
        setState(() {
          _accountCorrect = false;
          _accountErrMsg = "Can not be empty";
        });
      } else if (isMail || isTel) {
        setState(() {
          _accountCorrect = true;
          _accountErrMsg = null;
        });
      } else {
        setState(() {
          _accountCorrect = false;
          _accountErrMsg = "Can only input your phone number or mailbox";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var _accountTextField = TextField(
      decoration: InputDecoration(
        labelText: "Account",
        errorText: _accountErrMsg,
      ),
      controller: _accountController,
      maxLength: 24,
    );

    var _passwordTextField = TextField(
      obscureText: true,
      decoration: InputDecoration(
        errorText: _passwordErrMsg,
        labelText: "Password",
      ),
      controller: _passwordController,
    );

    String accountType(){
      return isMail ? "mail" : "tel";
    }  //校验邮箱

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: ListView(
          children:<Widget>[
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: <Widget>[
                  _accountTextField,
                  _passwordTextField,
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: _remember,
                        activeColor: Colors.red, //选中时的颜色
                        onChanged:(value){
                          setState(() {
                            _remember=value;
                          });
                        } ,
                      ),
                      Text("Remember Password"),
                    ],
                  ),

                  Flex(
                    mainAxisAlignment: MainAxisAlignment.center,
                    direction: Axis.horizontal,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: _accountCorrect && _passwordCorrect
                            ? () async {
                          _loginMsg = "";

                          User user = new User();
                          user.userId = _accountController.text;
                          user.password = _passwordController.text;
                          List userList = Provider.of<UserCounter>(context).userList;
                          int i=0;
                          for(; i < userList.length; i++){
                            if(user.userId == userList[i].userId){   //之前保存了这个账号的信息了
                              user = userList[i];
                              res1 = await dioLoginWithCookie(dio);    //直接就用cookie登录了
                              setState(() {
                                isSent = true;
                              });
                             break;
                            }
                          }

                          if(i == userList.length){           //之前没有保存这个用户的账号
                            res1 = await dioLogin(dio, user, accountType(), _remember);
                            setState(() {
                              isSent = true;
                            });
                          }

                          ///登录成功
                          if (res1.statusCode == 200) {
                            try {
                              setState(() {
                                isSent = false;
                              });
                              user = User.fromJson(json.decode(res1.data));
                              if(_remember == true && i == userList.length){    //当前选择记住密码且之前没有保存这个用户的账号
                                Provider.of<UserCounter>(context).addUser(user);
                              }

                              dioGetAllCards(dio, user.userId).then((res2){

                                var list = json.decode(res2.data) as List;
                                List<CardInfo> cards = list.map((i)=> CardInfo.fromJson(i)).toList();
                                Provider.of<CardCounter>(context,listen:false).cardList = cards;
                              });
                              Navigator.of(context).pushNamed("/bottomMenu",arguments: {
                                "user": user,
                              });
                              _loginMsg = "Login Suceeded";

                            } on FormatException {
                              _loginMsg = "Login Failed";
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text("Alert"),
                                    content: Text(_loginMsg),
                                  ));
                            }
                          }

                          //登录失败
                          else if (res1.statusCode == 400) {
                            _loginMsg =
                            "Network connection failed, "
                                "check your network";
                            showDialog(context: context, builder: (_) => AlertDialog(
                              title: Text("Alert"),
                              content: Text(_loginMsg),
                            ));
                          }
                          else if (res1.statusCode == 406) {
                            _loginMsg = "Account does not exist or Password error";
                            showDialog(context: context, builder: (_) => AlertDialog(
                              title: Text("Alert"),
                              content: Text(_loginMsg),
                            ));
                          }
                          else{
                            _loginMsg = "Server error";
                            showDialog(context: context, builder: (_) => AlertDialog(
                              title: Text("Alert"),
                              content: Text(_loginMsg),
                            ));
                          }
                        }
                            : null,
                        color: Colors.amber,
                        child: Container(
                          child: Text(
                            "Sign In",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      MaterialButton(
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.of(context).pushNamed("/registerPage");
                        },
                        child: Container(
                          child: Text("Sign Up"),
                        ),
                      )
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/forgetPage");
                        },
                        child: Text("Forget password?",
                            style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.underline
                            )
                        ),
                      )
                    ],
                  ),
                  Container(
                    child: isSent
                        ? CircularProgressIndicator()
                        : Text(
                      _loginMsg == null ? "" : _loginMsg,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ]
      ),
    );
  }
}
