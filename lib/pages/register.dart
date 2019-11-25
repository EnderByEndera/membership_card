import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {
  String _usernameErrMsg;
  String _passwordErrMsg;

  var _usernameTextController = TextEditingController();
  var _passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _usernameTextController.addListener(() {});
    _passwordTextController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    var _usernameTextFiled = TextField(
      decoration: InputDecoration(
        hintText: "Username",
        labelText: "Username",
        errorText: _usernameErrMsg,
      ),
      controller: _usernameTextController,
    );

    var _passwordTextField = TextField(
      decoration: InputDecoration(
        hintText: "Password",
        labelText: "Password",
        errorText: _passwordErrMsg,
      ),
      controller: _passwordTextController,
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: <Widget>[
            _usernameTextFiled,
            _passwordTextField,
          ],
        ),
      ),
    );
  }
}
