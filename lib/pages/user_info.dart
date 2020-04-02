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
        title: Text("Me", textAlign:TextAlign.start,style: TextStyle(fontSize: 28.0,),
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            GestureDetector(
              //onTap: () { Navigator.of(context).pushNamed("/changePasswordPage"); },
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 30, 15, 15),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("assets/images/user_avatar.png"),
                    ),
                    SizedBox(width: 25),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '修改密码',
                            style: TextStyle(fontSize: 18),
                          ),
                          // SizedBox(height: 10),
                          // buildItems(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),

            GestureDetector(
              onTap: (){ Navigator.of(context).pushNamed("/settings");},
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: <Widget>[
                          Image.asset("assets/images/me_setting.png"),
                          SizedBox(width: 20),
                          Text("Settings", style: TextStyle(fontSize: 18)),
                          //Expanded(child: Container()),
                          //Image.asset('img/arrow_right.png'),
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey,
                      margin: EdgeInsets.only(left: 60),
                    ),
                  ],
                ),
              ),
            ),

            GestureDetector(
              onTap: (){ Navigator.of(context).pushNamed("/help"); },
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: <Widget>[
                          Image.asset("assets/images/me_about.png"),
                          SizedBox(width: 20),
                          Text("About", style: TextStyle(fontSize: 18)),
                          //Expanded(child: Container()),
                          //Image.asset('img/arrow_right.png'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}