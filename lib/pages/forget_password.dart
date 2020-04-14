import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:membership_card/model/user_model.dart';
import 'package:membership_card/network/client.dart';
import 'package:provider/provider.dart';
import 'dart:math';


class ForgetPasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ForgetPasswordPageState();
  }
}



class ForgetPasswordPageState extends State<ForgetPasswordPage> {
  var _emailController = TextEditingController();
  var _idController = TextEditingController();
  String _emailErrMsg;
  String _idErrMsg;
  String code;
  bool _emailCorrect = false;
  bool _idCorrect = false;
  var dio = initDio();
  Response res;




  @override
  void dispose() {
    _emailController.dispose();
    _idController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      if (_emailController.text.isEmpty) {
        setState(() {
          _emailCorrect = false;
          _emailErrMsg = "Can not be empty";
        });
      }
      else {
        setState(() {
          _emailCorrect = true;
          _emailErrMsg = null;
        });
      }
    }

    );
    _idController.addListener(() {
      if (_idController.text.isEmpty) {
        setState(() {
          _idCorrect = false;
          _idErrMsg = "Can not be empty";
        });
      }
      else {
        setState(() {
          _idCorrect = true;
          _idErrMsg = null;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    //Todo: implement build here
    var _nameTextField = TextField(
      decoration: InputDecoration(
        labelText: "Enter your Email",
        errorText: _emailErrMsg,
      ),
      controller: _emailController,
      maxLength: 24,
    );
    var _idTextField = TextField(
      decoration: InputDecoration(
        labelText: "Enter your id",
        errorText: _idErrMsg,
      ),
      controller: _idController,
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
            _idTextField,
            Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Spacer(),
                FlatButton(
                  onPressed: () {
                    print(_idController.text);
                    print(_emailController.text);
                    diogetenroll(dio, _idController.text).then((res){
                      print("send email\n");
                      print(res.statusCode);
                    });
                    dioForgetVerify(dio, _emailController.text);
                    showDialog(context: context, builder: (_) => emaildialog(_idController.text));
                  },

                  child: Text("OK",style: TextStyle(fontSize: 20.0),),

                )
              ],
            ),
          ],
        ),
      ),
    );

  }
  AlertDialog emaildialog(String id ){
    TextEditingController _textEditingController = new TextEditingController();

    return AlertDialog(
      title:Text("Enter verification code",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w700)),
      content: SizedBox(
        height: 45.0,
        child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Divider(),
              TextField(controller:_textEditingController,decoration: InputDecoration(labelStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),)),
              Divider(),
            ],
          ),
        ),
      ),
      actions:<Widget>[
        FlatButton(
          onPressed: (){

              Navigator.of(context).popAndPushNamed('/findpasswordpage',arguments:
              {"id":id,"code":_textEditingController.text});


          },
          child: Text("OK",
              style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}
