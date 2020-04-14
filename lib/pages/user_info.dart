import 'package:flutter/material.dart';
import 'package:membership_card/network/client.dart';
import 'package:membership_card/model/user_model.dart';

class UserInfoPage extends StatefulWidget {
  User user;
  UserInfoPage(this.user);

  @override
  State<StatefulWidget> createState() => UserInfoPageState(this.user);
}

class UserInfoPageState extends State<UserInfoPage> {
  User user;
  UserInfoPageState(this.user);

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
              onTap: () {},
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 30, 15, 15),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("assets/images/user_avatar.png"),
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(height: 10),

            GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed("/settings");
              },
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
                          Icon(Icons.settings),
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
              onTap: (){
                Navigator.of(context).pushNamed("/changePasswordPage",arguments: {
                  "user": user
                }
                );
              },
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
                          Icon(Icons.border_color),
                          SizedBox(width: 20),
                          Text("Password", style: TextStyle(fontSize: 18)),
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
              onTap: (){
                Navigator.of(context).pushNamed("/help");
              },
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
                          Icon(Icons.help),
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