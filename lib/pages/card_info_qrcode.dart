import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';
import 'package:membership_card/model/card_count.dart';
import 'package:membership_card/model/card_model.dart';
import 'package:membership_card/model/user_model.dart';
import 'package:membership_card/model/enterprise_model.dart';
import 'package:membership_card/model/enterprise_count.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:membership_card/network/client.dart';

/// This is the Card_Info Page showing one card's information with qrcode.
class CardInfo3Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CardInfo3State();
  }
}

class CardInfo3State extends State<CardInfo3Page>{
//  Dio dio = initDio();

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context).settings.arguments;
    CardInfo card = Provider.of<CardCounter>(context,listen:false).getCard(args["card"]);

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

    return SafeArea(
      child: Scaffold(
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
                Navigator.of(context).pushNamed("/edit", arguments: {
                  "card": args["card"],
                });
              },
            ),
          ],
        ),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              fit: StackFit.loose,
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(60),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: card.cardColor,
//                    image: DecorationImage(
//                        image: bytes!=null ? MemoryImage(bytes): AssetImage("assets/backgrounds/starbucksBackground.jpg"),
//                        fit: BoxFit.fitWidth
//                    ),
                  ),
                  height: 180.0,
                ),
                Positioned(
                  top: 10.0,
                  right: 10.0,
                  child: QrImage(
                    version: QrVersions.auto,
                    backgroundColor: Colors.white,
                    data: card.cardId,
                    size: 60.0,
                    padding: EdgeInsets.all(4.0),
                  ),
                ),
                Positioned(
                  bottom: 20.0,
                  left: 20.0,
                  child: Text(
                    card.eName,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Stack(
                children: <Widget>[

                  Positioned(
                    left: 10.0,
                    top: 10.0,
                    child: Text(
                      "MenberShip",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 25, color: Colors.grey),
                    ),
                  ),
                  Center(
                    child: QrImage(
                      version: QrVersions.auto,
                      backgroundColor: Colors.white,
                      data: card.cardId,
                      size: 200.0,
                      padding: EdgeInsets.all(4.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

