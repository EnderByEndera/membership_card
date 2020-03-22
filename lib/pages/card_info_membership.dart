import 'dart:ui';
import 'dart:ui' as prefix0;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix1;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:membership_card/model/card_count.dart';


/// This is the Card_Info Page showing one card's information.
/// It should include one card's all the information here.
class CardInfo1Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CardInfo1State();
  }
}

class CardInfo1State extends State<CardInfo1Page> {
  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Container(
              child: GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "< Back",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 25.0,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          actions: <Widget>[
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Edit",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 25.0,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              onTap: (){
                Navigator.of(context).pushNamed("/edit");
              },
            ),
          ],
        ),

        //Todo: Add more UI about Card Info body from here
        body: new ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image(
                    image: AssetImage(
                        "assets/backgrounds/starbucksBackground.jpg"),
                    //height: 300,
                    fit: BoxFit.fitWidth,
                  ),
                  Text(
                    " Add: 123 Conllins Street,Melbourne (3.1km)\n "
                    "Tel: (03) - 9883 8373\n "
                    "BH: Mon Wed Thur Fri Sat Sun (9am to 6pm)",
                    style:
                        TextStyle(color: Colors.grey, fontSize: 15, height: 2),
                    textAlign: TextAlign.left,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: args["cardcolor"],
                        borderRadius: BorderRadius.circular(10.0)),
                    constraints: BoxConstraints(minHeight: 160),
                    child: Stack(
                      fit: StackFit.passthrough,
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(16.0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            args["eName"],
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(16.0),
                          alignment: Alignment(-1.0, -0.3),
                          child: Text(
                            "Buy 5 Get 1 Free",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.all(16.0),
                            alignment: Alignment(-1, 0.1),
                            child: Text("Offer expires at 31/12/2019",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                ))),
                        Container(
                            margin: EdgeInsets.all(16.0),
                            alignment: Alignment(-1, 0.6),
                            child: Text(
                                "${5 - args["cardCoupon"]} "
                                    "More to go",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))),
                        Container(
                          height: 30,
                          child: ListView(
                            padding: EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 125.0, bottom: 2.0),
                            scrollDirection: Axis.horizontal,
                            children: _buildRewardPlace(args["cardCoupon"], 5, context),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                  ),
                  GestureDetector(
                    child: Stack(
                      children: <Widget>[
                        Image(
                          image: AssetImage("assets/coupon/green.png"),
                          //height: 300,
                          fit: BoxFit.fitWidth,
                        ),
                        Positioned(
                            left: 32.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                                ),
                                Text(
                                  "Ducks Coffee Roaster",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    height: 2.5,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "Add: 123 Collins Street\n"
                                      "Tel: 03 9847 8372",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    height: 1.2,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                                ),
                                Text(
                                  "Free Coffee Size Upgrade\n"
                                      "Enjoy the extra",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    height: 1.2,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            )
                        ),
                        Positioned(
                          right: 32.0,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                                ),
                                Image(
                                  image: AssetImage("assets/coupon/coffee.png"),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                                ),
                                Text(
                                  "Offer expires 31/12/2019",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ]),
                        )
                      ],
                    ),
                    onTap: (){
                      Navigator.pushNamed(context, "/couponpage");
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                  ),
                  GestureDetector(
                    child: Stack(
                      children: <Widget>[
                        Image(
                          image: AssetImage("assets/coupon/purple.png"),
                          //height: 300,
                          fit: BoxFit.fitWidth,
                        ),
                        Positioned(
                            left: 32.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                                ),
                                Text(
                                  "Ducks Coffee Roaster",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    height: 2.5,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "Add: 123 Collins Street\n"
                                      "Tel: 03 9847 8372",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    height: 1.2,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                                ),
                                Text(
                                  "Free Coffee Size Upgrade\n"
                                      "Enjoy the extra",
                                  style: TextStyle(
                                    color: Colors.purple,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    height: 1.2,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            )),
                        Positioned(
                          right: 32.0,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                                ),
                                Image(
                                  image: AssetImage("assets/coupon/coffee.png"),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                                ),
                                Text(
                                  "Offer expires 31/12/2019",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ]),
                        )
                      ],
                    ),
                    onTap: (){
                      Navigator.pushNamed(context, "/couponpage");
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                  ),
                  GestureDetector(
                    child: Stack(
                      children: <Widget>[
                        Image(
                          image: AssetImage("assets/coupon/orange.png"),
                          //height: 300,
                          fit: BoxFit.fitWidth,
                        ),
                        Positioned(
                            left: 32.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                                ),
                                Text(
                                  "Ducks Coffee Roaster",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    height: 2.5,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "Add: 123 Collins Street\n"
                                      "Tel: 03 9847 8372",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    height: 1.2,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                                ),
                                Text(
                                  "Free Coffee Size Upgrade\n"
                                      "Enjoy the extra",
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    height: 1.2,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            )),
                        Positioned(
                          right: 32.0,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                                ),
                                Image(
                                  image: AssetImage("assets/coupon/coffee.png"),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                                ),
                                Text(
                                  "Offer expires 31/12/2019",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ]),
                        )
                      ],
                    ),
                    onTap: (){
                      Navigator.pushNamed(context, "/couponpage");
                    },
                  ),
                ],
              );
            }
            )
    );
  }

  static List<Widget> _buildRewardPlace(int cardCoupon, int rewardPoint, BuildContext context){
    var rewardList = List<Widget>();
    for (int i = 1; i <= rewardPoint; i++) {
      rewardList.add(Container(
        constraints: BoxConstraints.tightFor(
            height: 33.0,
            width: (MediaQuery.of(context).size.width - 64.0) / 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
        ),
        alignment: Alignment.center,
        child:
        i > cardCoupon
            ? Text(i.toString(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ))
            : Image(
          image: AssetImage("assets/points/Polygon.png"),
        ),
      ));
    }
    return rewardList;
  }
}


//Container(
//            child: Image(
//              image: AssetImage("assets/backgrounds/starbucksBackground.jpg"),
//              //height: 300,
//              fit: BoxFit.fitWidth,
//            ),
//              decoration: BoxDecoration(gradient: LinearGradient(
//                colors: [
//                  Colors.grey,
//                ],
//                begin: FractionalOffset.topCenter,
//                end: FractionalOffset.bottomCenter,
//                tileMode: TileMode.repeated
//            )),
//          )

//Container(
//height: 100.0,
//child: Image(
//image: AssetImage("assets/images/EBGames.png"),
//),
//),
//new Expanded(
//child: new BarCodeImage(
//data: '321654987',
//codeType: BarCodeType.Code128,
//barHeight: 120.0,
//lineWidth: 1.0,
//hasText: true,
//onError: (error){
//print('error=$error');
//},
//),
//),
//new Center(
//child: Image(
//image: AssetImage("assets/backgrounds/nfcIllu.jpg"),
//),
//),
