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
      backgroundColor: Colors.white,
      appBar: AppBar(

        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
        //Todo: Add more UI for App bar from here

      ),
      //Todo: Add more UI about Card Info body from here
      body: Column(
        children: <Widget>[
          Image(
            image: AssetImage("assets/images/anz_card.png"),
            fit: BoxFit.fitWidth,
            height: 150.0,
          ),
          FlatButton(
          shape: BeveledRectangleBorder(
            side: BorderSide(
            color: Colors.black,
            width: 0.6,
          ),
          ),

            child: Text(
              "barcode",
              style: TextStyle(
              color: Colors.black45,
              ),
            ),
          hoverColor: Colors.red,
            onPressed: () {_openBarCodePage(args["cardId"]);},
          ),
          Wrap(
            spacing: 90.0,        // 主轴(水平)方向间距
            runSpacing: 4.0,      // 纵轴（垂直）方向间距
            alignment: WrapAlignment.center, //沿主轴方向居中
            children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Integral",
                  style: TextStyle(
                    height: 3.0,
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "500",
                  style: TextStyle(
                    height: 3.0,
                    fontSize: 20.0,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Coupons",
                  style: TextStyle(
                    height: 3.0,
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "0",
                  style: TextStyle(
                    height: 3.0,
                    fontSize: 20.0,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
          ),
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
