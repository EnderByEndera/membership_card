import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:membership_card/network/client.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:membership_card/network/cookie.dart';

class discountDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return discountDetailPageState();
  }
}

class discountDetailPageState extends State<discountDetailPage> {
  Dio dio = initDio();

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
//        title: ListTile(
//          leading: GestureDetector(
//            onTap: () {
//              Navigator.pop(context);
//            },
//            child: Container(
//              child: Padding(
//                padding: const EdgeInsets.all(0),
//                child: Text(
//                  "< Back",
//                  style: TextStyle(
//                    decoration: TextDecoration.none,
//                    fontSize: 25.0,
//                    color: Theme.of(context).primaryColor,
//                    fontWeight: FontWeight.w500,
//                  ),
//                ),
//              ),
//            ),
//          ),
//          title: Text(
//            args["enterprise"],
//            style: TextStyle(
//              decoration: TextDecoration.none,
//              fontSize: 25.0,
//              fontWeight: FontWeight.w500,
//            ),
//          ),
//        ),
        title: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Text(
                "< Back",
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 25.0,
                  color: Theme
                      .of(context)
                      .primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Builder(
          builder: (context) =>
              ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Image(
                          image: AssetImage(
                              "assets/backgrounds/starbucksBackground.jpg"),
                          //card.background
                          //height: 300,
                          fit: BoxFit.fitWidth,
                        ),
                        ListTile(
                          title: Text(
                            args["Coupons"],
//                            "discount 50%",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 25,
                                color: Color.fromARGB(255, 119, 136, 213),
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Card(
                          elevation: 10.0,
                          margin: new EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15.0),
                          color: Color.fromARGB(0, 255, 255, 255),
                          child: new Container(
                            width: 400.0,
                            height: 200.0,
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              image: new DecorationImage(
                                  image: new AssetImage("assets/coupon/coffee.png"),
                                  fit: BoxFit.contain),
                              shape: BoxShape.rectangle,
                              // <-- 这里需要设置为 rectangle
                              borderRadius: new BorderRadius.all(
                                const Radius.circular(15.0), // <-- rectangle 时，BorderRadius 才有效
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(8, 20, 8, 0),
                          child: Text(
                            args["Describe"],
//                            "use while buying hp's laptop",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(height: 30,),

                        RaisedButton(
                          color: Colors.blue,
                          highlightColor: Colors.blue[700],
                          colorBrightness: Brightness.dark,
                          splashColor: Colors.grey,
                          child: Text('领取', style: TextStyle(fontSize: 16)),
//              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          onPressed: () => getDialog(context, args["Id"], args["Enterprise"], args["CardType"]),
//                          onPressed: () => getDialog(context, 1, 'HP', 'Recharge'),

                        ),
                      ],
                    ),
                  ),
                ],
              )
      ),
    );
  }

  void getDialog(BuildContext context, int cardId, String eName, String cardtype) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder:(_) => AlertDialog(
          content: Text('确认领取优惠券?'),
//            title: Center(
//                child: Text(
//                  '您将会回到登陆页面',
//                  style: TextStyle(
//                      color: Colors.black,
//                      fontSize: 20.0,
//                      fontWeight: FontWeight.bold),
//                )),
          actions: <Widget>[
            FlatButton(
                onPressed: () async{

                  dioGetDiscountCard(dio, cardId, eName, cardtype).then((res) async{
                    print(res.statusCode);
                    if(res.statusCode==200){
                      Scaffold.of(context).showSnackBar(new SnackBar(
                        content: new Text("优惠券领取成功"),
                      ));
                    }
                    else if(res.statusCode==400){
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("Alert"),
                            content: Text("Fail to read"),
                          )
                      );
                    }
                    else if(res.statusCode==401){
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("Alert"),
                            content: Text("You are currently not logged in!"),
                          )
                      );
                    }
                    else if(res.statusCode==403){
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("Alert"),
                            content: Text("The card has been collected by others"),
                          )
                      );
                    }
                    else if(res.statusCode==405){
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("Alert"),
                            content: Text("Get card failed!"),
                          )
                      );
                    }
                    Navigator.of(context).pop();
                  });
                },
                child: Text('是'),
            ),

            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('否')),
          ],
        ));

  }

}
