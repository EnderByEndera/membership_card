import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// This is the Card_Info Page showing one card's information with qrcode.
class CardInfo3Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CardInfo3State();
  }
}

class CardInfo3State extends State<CardInfo3Page>{
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
                  color: args["cardcolor"],
                ),
                height: 180.0,
              ),
              Positioned(
                top: 10.0,
                right: 10.0,
                child: QrImage(
                  version: QrVersions.auto,
                  backgroundColor: Colors.white,
                  data: args["cardId"],
                  size: 60.0,
                  padding: EdgeInsets.all(4.0),
                ),
              ),
              Positioned(
                bottom: 20.0,
                left: 20.0,
                child: Text(
                  args["eName"],
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
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
                Center(
                  child: QrImage(
                    version: QrVersions.auto,
                    backgroundColor: Colors.white,
                    data: args["cardId"],
                    size: 200.0,
                    padding: EdgeInsets.all(4.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

