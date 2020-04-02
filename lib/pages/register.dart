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
  String _passwordErrMsg;
  bool _usernameCorrect = false;
  bool _passwordCorrect = false;
  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();

  String _registerMsg;
  bool isSent = false;
  var dio = initDio();
  Response res;

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
          _usernameErrMsg = "Can only input 0-9, a-z and A-Z";
        });
      } else {
        setState(() {
          _usernameCorrect = true;
          _usernameErrMsg = null;
        });
      }
    });
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

    var _passwordTextField = TextField(
      decoration: InputDecoration(
        hintText: "Password",
        labelText: "Password",
        errorText: _passwordErrMsg,
      ),
      controller: _passwordController,
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
            MaterialButton(
              onPressed: _usernameCorrect && _passwordCorrect
                  ? () async {
                _registerMsg = "";
                setState(() {
                  isSent = true;
                });
                User user = User(_usernameController.text,_passwordController.text);
                res = await dioRegister(dio, user);
                setState(() {
                  isSent = false;
                });
                if (res.statusCode == 200) {
                  print("${res.data}");
                  try {
                    Map<String, dynamic> json =
                    jsonDecode(res.data);
                    if (json["registerInfo"] == "success") {
                      _registerMsg = "Register Succeeded";
                      Navigator.pushNamed(context, "/loginPage");
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
                } else if (res.statusCode == 400 ||
                    res.statusCode == 404) {
                  _registerMsg =
                  "Network connection failed, "
                      "check your network";
                  showDialog(context: context, builder: (_) => AlertDialog(
                    title: Text("Alert"),
                    content: Text(_registerMsg),
                  ));
                } else if (res.statusCode >= 500) {
                  _registerMsg = "Server error";
                }
              } : null,
              color: Colors.blue,
              child: Container(
                child: Text(
                  "Sign Up",
                  textAlign: TextAlign.center,
                  //tyle: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
