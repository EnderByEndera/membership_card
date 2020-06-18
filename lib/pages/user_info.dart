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

  void showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Are tou sure to sign out?'),
            title: Center(
                child: Text(
                  'You Will Go back to the login page',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                )),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        "/loginPage", (route) => route == null
                    );
                  },
                  child: Text('YES')),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('NO')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text("Me", textAlign:TextAlign.start,style: TextStyle(fontSize: 28.0,color: Theme.of(context).primaryColor,),
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
                    SizedBox(width: 20.0,),
                    Text('id: ${user.userId}',style: TextStyle(fontSize: 18.0),)
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

            SizedBox(height: 70),

            GestureDetector(
              onTap: (){
                showAlertDialog(context);
              },
              child: Container(
                decoration:  BoxDecoration(
                  color: Colors.white,
                  border: new Border.all(color: Colors.orange, width: 2.0),
                  borderRadius: new BorderRadius.circular((5.0)),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      child:Text("Sign Out", textAlign: TextAlign.center,style: TextStyle(fontSize: 15,color: Colors.red,fontWeight: FontWeight.bold)),
                      //Expanded(child: Container()),
                      //Image.asset('img/arrow_right.png'),
                    ),

                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}