import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class SettingsPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
          color: Colors.orange,
        ),
        backgroundColor: Colors.white,
       title: Text("Setting", textAlign:TextAlign.start,style: TextStyle(fontSize: 28.0,color: Colors.orange,),),
        //Todo: Add more UI for the App bar
      ),


      body:  Container(
      child: ListView(
      children: <Widget>[
        SizedBox(height: 300,),
//        GestureDetector(
//          onTap: (){
//           showAlertDialog(context);
//          },
//          child: Container(
//            decoration:  BoxDecoration(
//              color: Colors.white,
//              border: new Border.all(color: Colors.orange, width: 2.0),
//              borderRadius: new BorderRadius.circular((5.0)),
//            ),
//            child: Column(
//              children: <Widget>[
//                Container(
//                  color: Colors.white,
//                  height: 50,
//                  padding: EdgeInsets.symmetric(horizontal: 20),
//                  alignment: Alignment.center,
//                      child:Text("Sign Out", textAlign: TextAlign.center,style: TextStyle(fontSize: 18,color: Colors.red,fontWeight: FontWeight.bold)),
//                      //Expanded(child: Container()),
//                      //Image.asset('img/arrow_right.png'),
//                ),
//
//              ],
//            ),
//          ),
//        )

      ],
     )
      )
      //Todo: Add more UI for settings
      /// This is the test for github
      /// commit and update


    );

  }
}