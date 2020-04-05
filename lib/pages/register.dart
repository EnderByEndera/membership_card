import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:membership_card/model/user_model.dart';
import 'package:membership_card/network/client.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {
  String _usernameErrMsg;
  String _emailErrMsg;
  String _passwordErrMsg;
  String _passwordRepeatErrMsg;
  String _verifyCodeErrMsg;
  String _verifyCode;
  bool _usernameCorrect = false;
  bool _emailCorrect = false;
  bool _passwordCorrect = false;
  bool _passwordRepeatCorrect = false;
  bool _verifyCorrect = false;
  var _usernameController = TextEditingController();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _passwordRepeatController = TextEditingController();
  var _verifyController = TextEditingController();

  User user;
  String _registerMsg;
  bool isSent = false;
  var dio = initDio();
  Response resVerify;
  Response resSignUp;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(() {
      if (_usernameController.text.isEmpty) {
        setState(() {
          _usernameCorrect = false;
          _usernameErrMsg = "Can not be empty";
        });
      } else if (_usernameController.text.contains(RegExp(r"\W"))) {
        setState(() {
          _usernameCorrect = false;
          _usernameErrMsg = "Can only input English and Numbers";
        });
      } else {
        setState(() {
          _usernameCorrect = true;
          _usernameErrMsg = null;
        });
      }
    });

    _emailController.addListener(() {
      if (_emailController.text.contains(RegExp(r"\W"))) {
        setState(() {
          _emailCorrect = false;
          _emailErrMsg = "Can only input English and Numbers";
        });
      } else if (_emailController.text.isEmpty) {
        setState(() {
          _emailCorrect = false;
          _emailErrMsg = "Email can not be empty";
        });
      } else {
        setState(() {
          _emailCorrect = true;
          _emailErrMsg = null;
        });
      }
    });

    _passwordController.addListener(() {
      if (_passwordController.text.contains(RegExp(r"\W"))) {
        setState(() {
          _passwordCorrect = false;
          _passwordErrMsg = "Can only input English and Numbers";
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

    _passwordRepeatController.addListener(() {
      if (_passwordController.text != _passwordController.text) {
        setState(() {
          _passwordRepeatCorrect = false;
          _passwordRepeatErrMsg = "The two passwords you typed do not match";
        });
      } else {
        setState(() {
          _passwordRepeatCorrect = true;
          _passwordRepeatErrMsg = null;
        });
      }
    });


    _verifyController.addListener(() {
      if (_verifyController.text != _verifyCode) {
        setState(() {
          _verifyCorrect = false;
          _verifyCodeErrMsg = "Wrong verification code";
        });
      } else if (_passwordController.text.isEmpty) {
        setState(() {
          _verifyCorrect = false;
          _verifyCodeErrMsg = "Verification code can not be empty";
        });
      } else {
        setState(() {
          _verifyCorrect = true;
          _verifyCodeErrMsg = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var _usernameTextFiled = TextField(
      decoration: InputDecoration(
        hintText: "Username",
        labelText: "Username",
        errorText: _usernameErrMsg,
      ),
      controller: _usernameController,
    );

    var _emailTextField = TextField(
      decoration: InputDecoration(
        hintText: "Email",
        labelText: "Email",
        errorText: _emailErrMsg,
      ),
      controller: _emailController,
    );

    var _passwordTextField = TextField(
      decoration: InputDecoration(
        hintText: "Password",
        labelText: "Password",
        errorText: _passwordErrMsg,
      ),
      controller: _passwordController,
    );

    var _passwordRepeatTextField = TextField(
      decoration: InputDecoration(
        hintText: "RepeatPassword",
        labelText: "RepeatPassword",
        errorText: _passwordRepeatErrMsg,
      ),
      controller: _passwordRepeatController,
    );

    var _verifyCodeTextField = TextField(
      decoration: InputDecoration(
        hintText: "VerificationCode",
        labelText: "VerificationCode",
        errorText: _verifyCodeErrMsg,
      ),
      controller: _verifyController,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Register Your Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: <Widget>[
            _usernameTextFiled,
            _passwordTextField,
            _passwordRepeatTextField,
            Row(
              children: <Widget>[
                _emailTextField,
                MaterialButton(
                  onPressed: () async {
                    user.username = _usernameController.text;
                    user.password = _passwordController.text;
//                    user.email = _emailController.text;
                    resVerify = await dioRegisterVerify(dio, user);

                  },
                  child: Container(
                    child: Text(
                      "Send Verification code",
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
            _verifyCodeTextField,
            MaterialButton(
              onPressed: _usernameCorrect && _passwordCorrect && _passwordRepeatCorrect && _verifyCorrect && _emailCorrect
                  ? () async {
                _registerMsg = "";
                setState(() {
                  isSent = true;
                });
//                User user = User(_usernameController.text,_passwordController.text);
                resSignUp = await dioRegister(dio, user);
                setState(() {
                  isSent = false;
                });
                if (resSignUp.statusCode == 200) {
                  print("${resSignUp.data}");
                  try {
                    Map<String, dynamic> json = jsonDecode(resSignUp.data);
                    if (json["registerInfo"] == "success") {
                      _registerMsg = "Register Succeeded";
                      Navigator.of(context).pop();
                    } else {
                      _registerMsg = "Register Failed!";
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("Alert"),
                            content: Text(_registerMsg),
                          ));
                    }
                  } on FormatException {
                    _registerMsg = "Register Failed";
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text("Alert"),
                          content: Text(_registerMsg),
                        ));
                  }
                } else if (resSignUp.statusCode == 400 ||
                    resSignUp.statusCode == 404) {
                  _registerMsg =
                  "Network connection failed, "
                      "check your network";
                  showDialog(context: context, builder: (_) => AlertDialog(
                    title: Text("Alert"),
                    content: Text(_registerMsg),
                  ));
                } else if (resSignUp.statusCode >= 500) {
                  _registerMsg = "Server error";
                }
              } : null,
              color: Colors.blue,
              child: Container(
                child: Text(
                  "Sign Up",
                  textAlign: TextAlign.center,
                  //style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
