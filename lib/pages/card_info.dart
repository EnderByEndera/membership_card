import 'package:flutter/material.dart';
import 'package:barcode_flutter/barcode_flutter.dart';
/// This is the Card_Info Page showing one card's information.
/// It should include one card's all the information here.
class CardInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CardInfoState();
  }
}

class CardInfoState extends State<CardInfoPage> {
  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
        //Todo: Add more UI for App bar from here
        title: Text(
              args["cardType"],
              style: TextStyle(
                  color: Colors.black,
                  ),
            ),


      ),
      //Todo: Add more UI about Card Info body from here
      body: Column(
        children: <Widget>[
          Image(
            image: AssetImage("assets/images/anz_card.png"),
            fit: BoxFit.fitWidth,
          ),
          OutlineButton(
            child: Text(
              "barcode",
              style: TextStyle(
              color: Colors.grey,
            ),),
            onPressed: () {_openBarCodePage(args["cardId"]);},
          )
        ],
      ),
    );
  }
  void _openBarCodePage(String cardNumberData){
    Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (BuildContext context){
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.black,
            ),
            title: Text(
              "Barcode",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          body: new Center(
            child: new BarCodeImage(
              data: cardNumberData,
              codeType: BarCodeType.Code128,
              lineWidth: 2.0,
              barHeight: 120.0,
              hasText: true,
              onError: (error){
                print('error=$error');
              },
            ),
          ),
        );
      }
    )
    );
  }
}
