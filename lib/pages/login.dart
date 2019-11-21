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
          _passwordErrMsg = "Password format not correct";
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
          _usernameErrMsg = "Username can not be empty";
        });
      } else if (_usernameController.text.contains(RegExp(r"\W"))) {
        setState(() {
          _usernameCorrect = false;
          _usernameErrMsg = "Username format not correct";
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
    // TODO: implement build
    var _nameTextField = TextField(
      decoration: InputDecoration(
        labelText: "Username",
        hintText: "Username",
        errorText: _usernameErrMsg,
      ),
      controller: _usernameController,
    );

    var _passwordTextField = TextField(
      obscureText: true,
      decoration: InputDecoration(
        errorText: _passwordErrMsg,
        labelText: "Password",
        hintText: "Password",
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
            Consumer<User>(
              builder: (context, user, child) => MaterialButton(
                onPressed: _usernameCorrect && _passwordCorrect
                    ? () async {
                        _loginMsg = "";
                        setState(() {
                          isSent = true;
                        });
                        res = await dioPostLogin(dio, user);
                        setState(() {
                          isSent = false;
                        });
                        if (res.statusCode == 200) {
                          Map<String, dynamic> json = jsonDecode(res.data);
                          if (json["loginInfo"] == "success") {
                            _loginMsg = "Login Succeeded";
                            Navigator.pushNamed(context, "/allcardspage");
                          } else {
                            _loginMsg = "Login Failed";
                          }
                        } else if (res.statusCode == 404) {
                          _loginMsg =
                              "Network connection failed, check your network";
                        } else if (res.statusCode >= 500) {
                          _loginMsg = "Server error";
                        }
                      }
                    : null,
                child: Container(
                  child: isSent
                      ? CircularProgressIndicator()
                      : Text(
                          "Login",
                          textAlign: TextAlign.center,
                        ),
                ),
              ),
            ),
            Text(
              _loginMsg == null ? "" : _loginMsg,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
