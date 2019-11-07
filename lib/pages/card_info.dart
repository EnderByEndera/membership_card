import 'package:flutter/material.dart';

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
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
        //Todo: Add more UI for App bar from here
        title: Row(
          children: <Widget>[
            Icon(
              Icons.account_balance_wallet,
              color: Colors.deepOrange,
            ),
            Text(
              "     " + args["cardType"],
              style: TextStyle(
                  //fontSize: 16.0,
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic
                  //fontWeight: FontWeight.w600),
                  ),
            ),
          ],
        ),
      ),
      //Todo: Add more UI about Card Info body from here
      body: Column(
        children: <Widget>[
          Image(
            image: AssetImage("assets/images/anz_card.png"),
            fit: BoxFit.fitWidth,
          ),
          FlatButton(
            child: Text("barcode"),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
