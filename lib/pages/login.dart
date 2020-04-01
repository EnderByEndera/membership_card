import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:membership_card/model/user_model.dart';
import 'package:membership_card/network/client.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  var _passwordController = TextEditingController();
  var _usernameController = TextEditingController();

  bool isSent = false;
  bool _usernameCorrect = false;
  bool _passwordCorrect = false;
  String _loginMsg;
  String _usernameErrMsg;
  String _passwordErrMsg;

  var dio = initDio();
  Response res;

  @override
  void dispose() {
    _passwordController.dispose();
    _usernameController.dispose();
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
  }

  @override
  Widget build(BuildContext context) {
    var _nameTextField = TextField(
      decoration: InputDecoration(
        labelText: "Name/Mail/Tel",
        errorText: _usernameErrMsg,
      ),
      controller: _usernameController,
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

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: <Widget>[
            _nameTextField,
            _passwordTextField,
            Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Spacer(),
                FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/forgetPage");
                  },
                  child: Text("Forget password?"),
                )
              ],
            ),
            Consumer<User>(
              builder: (context, user, child) => Flex(
                mainAxisAlignment: MainAxisAlignment.center,
                direction: Axis.horizontal,
                children: <Widget>[
                  MaterialButton(
                    onPressed: _usernameCorrect && _passwordCorrect
                        ? () async {
                            _loginMsg = "";
                            setState(() {
                              isSent = true;
                            });
                            user.username = _usernameController.text;
                            user.password = _passwordController.text;
                            res = await dioLogin(dio, user);
                            setState(() {
                              isSent = false;
                            });
                            if (res.statusCode == 200) {
                              print("${res.data}");
                              try {
                                Map<String, dynamic> json =
                                    jsonDecode(res.data);
                                if (json["loginInfo"] == "success") {
                                  _loginMsg = "Login Succeeded";
                                  Navigator.pushNamed(context, "/allCardsPage",arguments: {
                                    "user": user,
                                  });
                                } else {
                                  _loginMsg = "Login Failed!";
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            title: Text("Alert"),
                                            content: Text(_loginMsg),
                                          ));
                                }
                              } on FormatException {
                                _loginMsg = "Login Failed";
                                showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                          title: Text("Alert"),
                                          content: Text(_loginMsg),
                                        ));
                              }
                            } else if (res.statusCode == 400 ||
                                res.statusCode == 404) {
                              _loginMsg =
                                  "Network connection failed, "
                                      "check your network";
                              showDialog(context: context, builder: (_) => AlertDialog(
                                title: Text("Alert"),
                                content: Text(_loginMsg),
                              ));
                            } else if (res.statusCode >= 500) {
                              _loginMsg = "Server error";
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
    );
  }
}
