import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as prefix0;
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix1;
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:membership_card/network/client.dart';
import 'package:membership_card/model/card_model.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:membership_card/model/card_count.dart';
import 'package:membership_card/model/user_model.dart';
import 'package:membership_card/model/enterprise_model.dart';
import 'package:membership_card/model/enterprise_count.dart';
import 'dart:convert';
/// This is the Card_Info Page showing one card's information.
/// It should include one card's all the information here.
class CardInfo1Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CardInfo1State();
  }
}

class CardInfo1State extends State<CardInfo1Page> {
  //Response res;
  Dio dio = initDio();

  ScrollController _scrollController;
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      keepScrollOffset: false,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context).settings.arguments;
    CardInfo card = Provider.of<CardCounter>(context,listen:false).getCard(args["card"]);
    int itemNum = card.couponsNum + 3;

//    List<EnterpriseInfo> list = Provider.of<EnterpriseCounter>(context).enterpriseList;
//    String back_CaptchaCode;
//    for(int i = 0; i < list.length; i++){
//      if(list[i].enterpriseName == card.eName){
//
//        String enterpriseId = list[i].enterpriseId;
//
//        dioGetEnterpriseInfo(dio, enterpriseId).then((res) async{
//          print(res.statusCode);
//          print(res.data);
//          if(res.statusCode==200){
//            Map<String, dynamic> js = res.data;
//            back_CaptchaCode = EnterpriseDemo.fromJson(js).base64;
//          }
//        }
//        );
//        break;
//      }
//    }
//    //商家店面背景
//    back_CaptchaCode = back_CaptchaCode.split(',')[1];
//    Uint8List bytes = Base64Decoder().convert(back_CaptchaCode);

    return Scaffold(
        backgroundColor: Colors.white,
        //Todo: Add more UI about Card Info body from here
        body: SafeArea(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
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
                    onTap: () {
                      Navigator.of(context).pushNamed("/edit", arguments: {
                        "card": card,
                      });
                    }
                  ),
                ],
              ),

              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                         // return Consumer<CardCounter>();
                      if(index < itemNum){
                        try{
                          if (index == 0) {
//                            if(bytes!=null){
//                              return Image.memory(bytes, fit: BoxFit.fitWidth,);
//                            }
//                            else{
//                              return Image.asset("assets/backgrounds/starbucksBackground.jpg");
//                            }
                            return Image.asset("assets/backgrounds/starbucksBackground.jpg", fit: BoxFit.fitWidth,);
                          }
                          if(index == 1){
                            return  Text(
                              " City: " + card.city + "\n" +
//                              " City: "  "\n" +
//                              "Tel: " + card.tel + "\n" +
//                                  " Tel: "  "\n" +
                              " BH: " + card.startTime + "\n",
//                                  " BH: "  "\n",
                              style:
                              TextStyle(color: Colors.grey, fontSize: 15, height: 2),
                              textAlign: TextAlign.left,
                            );
                          }
                          if(index == 2){
                            return Container(
                              decoration: BoxDecoration(
                                  color: card.cardColor,
                                  borderRadius: BorderRadius.circular(10.0)),
                              constraints: BoxConstraints(minHeight: 160),
                              child: Stack(
                                fit: StackFit.passthrough,
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.all(20.0),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      card.eName,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(20.0),
                                    alignment: Alignment(-1.0, -0.3),
                                    child: Text(
                                      "Buy " + card.discountTimes.toString()+" Get 1 Free",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.all(20.0),
                                      alignment: Alignment(-1, 0.1),
                                      child: Text("Offer expires at " + card.expireTime,
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.white,
                                          ))),
                                  Container(
                                      margin: EdgeInsets.all(20.0),
                                      alignment: Alignment(-1, 0.6),
                                      child: Text(
                                          "${card.currentScore % card.discountTimes} "
                                              "More to go",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white))),
                                  Container(
                                    height: 30,
                                    child: ListView(
                                      padding: EdgeInsets.only(
                                          left: 20.0, right: 20.0, top: 125.0, bottom: 2.0),
                                      scrollDirection: Axis.horizontal,
                                      children: _buildRewardPlace(card.currentScore % card.discountTimes , card.discountTimes, context),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                          else if ((index-3) % 2 == 0) {
                            return GestureDetector(
                              child: Stack(
                                children: <Widget>[
                                  _buildCouponWithColor(context, index),

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
                                            card.eName,
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                              height: 2.5,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            " City: " + card.city + "\n",
//                                            "City: "  "\n",
//                                            "Tel: " + card.tel + "\n",
//                                                "Tel: "  "\n",
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
//                                            card.description+"\n" +
//                                            "\n"
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
                                            image: AssetImage("assets/coupon/coffee.png"),   //args["icon"]
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.symmetric(vertical: 20.0),
                                          ),
                                          Text(
                                            "Offer expires at" + args["expireTime"],
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
                                Navigator.pushNamed(context, "/couponpage",  arguments: {
                                  "card": card,
                                  "coupon": _buildCouponWithColor(context, index),
                                });
                              },
                            ) ;
                          }
                          else {
                            return  Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                            );
                          }
                        }on Exception{
//                          return Image(
//                            image: AssetImage("assets/backgrounds/starbucksBackground.jpg"),   //card.background
//                            //height: 300,
//                            fit: BoxFit.fitWidth,
//                          );
                        return Container();
                        }
                      }
                      else{
                        return null;
                      }
                    },
                    //childCount: itemNum,
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }

  static List<Widget> _buildRewardPlace(int score, int rewardPoint, BuildContext context){
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
        i > score
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

  Widget _buildCouponWithColor(BuildContext context, int index){
    if((index-3) % 6 == 0){          //for color green
      return Image(
        image: AssetImage("assets/coupon/green.png"),
        //height: 300,
        fit: BoxFit.fitWidth,
      );
    }
    else if((index-3) % 6 == 2){          //for color purple
      return Image(
        image: AssetImage("assets/coupon/purple.png"),
        //height: 300,
        fit: BoxFit.fitWidth,
      );
    }
    else if((index-3) % 6 == 4){          //for color orange
      return Image(
        image: AssetImage("assets/coupon/orange.png"),
        //height: 300,
        fit: BoxFit.fitWidth,
      );
    }
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
