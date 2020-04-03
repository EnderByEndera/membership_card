import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:membership_card/model/user_model.dart';
import 'package:membership_card/network/client.dart';
import 'package:provider/provider.dart';
class ForgetPasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ForgetPasswordPageState();
  }
}
class ForgetPasswordPageState extends State<ForgetPasswordPage> {
  var _emailController = TextEditingController();
  String _emailErrMsg;
  bool _usernameCorrect = false;
  var dio = initDio();
  Response res;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      if (_emailController.text.isEmpty) {
        setState(() {
          _usernameCorrect = false;
          _emailErrMsg = "Can not be empty";
        });
      } else if (_emailController.text.contains(RegExp(r"\W"))) {
        setState(() {
          _usernameCorrect = false;
          _emailErrMsg = "Can only input 0-9, a-z and A-Z";
        });
      } else {
        setState(() {
          _usernameCorrect = true;
          _emailErrMsg = null;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    //Todo: implement build here
    var _nameTextField = TextField(
      decoration: InputDecoration(
        labelText: "Enter your email",
        errorText: _emailErrMsg,
      ),
      controller: _emailController,
      maxLength: 24,
    );


    return Scaffold(
      appBar: AppBar(
        title:Text('Forget Password'),
      ),
        body: Padding(
        padding: const EdgeInsets.all(24.0),
              child: Column(
              children: <Widget>[
                _nameTextField,
                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Spacer(),
                    FlatButton(

                      onPressed: () {
                        showDialog(context: context, builder: (_) => emaildialog());

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
  AlertDialog emaildialog(){
    TextEditingController _textEditingController = new TextEditingController();

    return AlertDialog(
      title:Text("Enter verification code",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w700)),
      content: SizedBox(
        height: 45.0,
         child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Divider(),
              TextField(
                  controller:_textEditingController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  )
              ),
              Divider(),
            ],
          ),
         ),
      ),
      actions:<Widget>[
        FlatButton(
          onPressed: (){

            Navigator.of(context).pop();//之后改为修改密码的界面

          },
          child: Text("OK",
              style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}
