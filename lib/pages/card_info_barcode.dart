import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode_flutter/barcode_flutter.dart';

/// This is the Card_Info Page showing one card's information with barcode.
class CardInfo2Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CardInfo2State();
  }
}

class CardInfo2State extends State<CardInfo2Page>{
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

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(60),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: args["cardcolor"],
            ),
            height: 180.0,
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Image(
                  image: AssetImage("assets/backgrounds/nfcIllu.jpg"),
                  alignment: Alignment.center,
                  color: Colors.white,
                  colorBlendMode: BlendMode.color,
                ),
                Positioned(
                  left: 10.0,
                  top: 10.0,
                  child: Text(
                    "MenberShip",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 25, color: Colors.grey),
                  ),
                ),
                Positioned(
                  top: 120.0,
                  right: 20.0,
                  left: 20.0,
                  child:Center(
                    child: BarCodeImage(
                      data: args["cardId"],
                      codeType: BarCodeType.Code128,
                      lineWidth: 2.0,
                      barHeight: 140.0,
                      //hasText: true,
                      onError: (error){
                        print('error=$error');
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 120,
                  right: 20.0,
                  left: 20.0,
                  child: Center(
                    child: Text(
                      args["cardId"],
                      style: TextStyle(fontSize: 36, color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}