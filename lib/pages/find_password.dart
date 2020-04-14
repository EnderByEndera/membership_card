import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:membership_card/network/client.dart';

class FindPasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FindPasswordPageState();
  }
}

class FindPasswordPageState extends State<FindPasswordPage> {
  var dio = initDio();
  Response res;
  var _passwordController = TextEditingController();
  bool _passwordCorrect = false;
  String _passwordErrMsg;
  @override
  void dispose() {
    _passwordController.dispose();

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
    });}

  @override
  Widget build(BuildContext context) {

    dynamic args = ModalRoute.of(context).settings.arguments;
    var _passwordTextField = TextField(
      obscureText: true,
      decoration: InputDecoration(
        errorText: _passwordErrMsg,
        labelText: "Enter Your New Password",
      ),
      controller: _passwordController,
    );
    return Scaffold(
      appBar: AppBar(
        title:Text('Forget Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: <Widget>[
            _passwordTextField,
            Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Spacer(),
                FlatButton(

                  onPressed: () {
                    print(args["id"]);
                    print(args["code"]);
                    dioforgetpassword(dio,args["id"], _passwordController.text,args["code"]).then((res){
                      print(res.statusCode);
                    });
                    Navigator.of(context).popAndPushNamed('/loginPage'); //之后改为修改密码的界面

                  },

                  child: Text("确认",style: TextStyle(fontSize: 20.0),),

                )
              ],
            ),
          ],
        ),
      ),
    );

  }




}
