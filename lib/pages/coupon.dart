import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:membership_card/model/card_model.dart';
import 'package:membership_card/network/client.dart';
import 'package:membership_card/pages/card_info_membership.dart';
import 'package:membership_card/model/user_model.dart';

class CouponPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CouponPageState();
  }
}

/// This is the [CouponPageState] used for CouponPage
/// It builds a widget which you can do some operations about coupons
/// It contains Redeem Button which is tapped by the staff in the shop
/// when the button is tapped, the coupon will be consumed
/// This should be the upper-stack page of [CardInfoPage]
class CouponPageState extends State<CouponPage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  Dio dio = initDio();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Coupon",
            style: TextStyle(color: Theme
                .of(context)
                .primaryColor),
          ),
          backgroundColor: Colors.white),
      body: SafeArea(
        child: Flex(direction: Axis.vertical, children: <Widget>[
          Container(
            child: Stack(
              fit: StackFit.passthrough,
              children: <Widget>[
                args["coupon"],
                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.245,
                  margin: EdgeInsets.symmetric(horizontal: 32.0),
                  alignment: Alignment(-1, -0.7),
                  child: Text(
                    '\n',
                    //args["card"]._eName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                        fontSize: 14.0),
                  ),
                ),
                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.245,
                  margin: EdgeInsets.symmetric(horizontal: 32.0),
                  alignment: Alignment(-1, -0.4),
                  child: Text(
                    "Add:\n"
                      "Tel:\n",
                    //"Add: " + args["card"]._address + "\n"
                    //    + "Tel: " + args["card"]._tel,
                    style: TextStyle(color: Colors.grey[500], fontSize: 12.0),
                  ),
                ),
                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.245,

                  margin: EdgeInsets.symmetric(horizontal: 32.0),
                  alignment: Alignment(-1, 0.3),
                  child: Text(
                    '\n'
                      "Enjoy your Extra",
                    //args["card"]._description,
                    style: TextStyle(
                        color: Color.fromARGB(255, 59, 157, 9),
                        fontSize: 14.0),
                  ),
                ),
                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.245,
                  margin: EdgeInsets.symmetric(horizontal: 32.0),
                  alignment: Alignment(1, 0.8),
                  child: Text(
                    "Offer expires "
                      '\n',
                      //+ args["card"]._expireTime,
                    style: TextStyle(color: Colors.grey[500], fontSize: 12.0),
                  ),
                ),
                Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.245,
                    alignment: Alignment(0.6, 0),
                    child: Image(
                      image: AssetImage("assets/coupon/coffee.png"),
                    ))
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Image(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.16,
                    image: AssetImage("assets/coupon/staffFig.png"),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      "Show this to staff in the shop, "
                          "who can tap on the button below"
                          "and redeem this coupon for you",
                      style: TextStyle(
                          fontSize: 16.0
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: MaterialButton(

                minWidth: MediaQuery
                    .of(context)
                    .size
                    .width * 0.5,
                onPressed: () {
                  showDialog(context: context, builder: (_) =>
                      AlertDialog(
                        title: Text("Use this Coupon?"),
                        content: Text(
                            "Do you want to redeem this coupon and make "
                                "it as used?"),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancel", style: TextStyle(color: Theme
                                .of(context)
                                .primaryColor),),
                          ),
                          FlatButton(
                            onPressed: () {
                                dioUseCoupon(dio, args["card"].cardId, -1).then((res){
                                  if (res.statusCode == 200) {
                                    args["card"].redeemCoupon();
                                    Navigator.of(context).popUntil(
                                        ModalRoute.withName(
                                            "/cardinfo_membership"));
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: Text("Error"),
//                                          content: Text(jsonDecode(res.data)[""]),
                                        )
                                    );
                                  }
                                });
                            },
                            child: Text(
                                "Redeem Now", style: TextStyle(color: Theme
                                .of(context)
                                .primaryColor)),
                          )
                        ],
                      ));
                },
                child: Text(
                  "Redeem",
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme
                    .of(context)
                    .primaryColor,
              ),
            ),
          )
        ]),
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        tabs: <Widget>[
          Hero(
            tag: 'tab one',
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.066,
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.topCenter,
              child: Image(
                image: AssetImage("assets/backgrounds/tabCard.png"),
              ),
            ),
          ),
          Hero(
            tag: 'tab two',
            child: Container(
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.topCenter,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.066,
              child: Image(
                image: AssetImage("assets/backgrounds/tabUser.png"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
