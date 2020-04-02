import 'package:flutter/material.dart';
import 'package:membership_card/network/client.dart';

class UserInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserInfoPageState();
  }
}

class UserInfoPageState extends State<UserInfoPage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: Text("Me", textAlign:TextAlign.left,style: TextStyle(fontSize: 25.0,),
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}