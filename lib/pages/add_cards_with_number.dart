///This page is the add card page.
///The user can jump to this page by clicking the Add button in the main page, and enter the user's card number,
///card type and card notes here. After adding, click the back button
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:membership_card/model/card_count.dart';
import 'package:membership_card/model/card_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';

class AddCardWithNumberPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddCardWithNumberPageState();
}

class AddCardWithNumberPageState extends State<AddCardWithNumberPage> {
  ///Force the page to remain vertical
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  ///Destroy vertical lock
  void dispose() {
    SystemChrome.setPreferredOrientations([]);
    super.dispose();
  }

  ///card control
  TextEditingController cardController = TextEditingController();

  ///card type control
  TextEditingController cardTypeController = TextEditingController();

  ///card remark control
  TextEditingController cardRemarkController = TextEditingController();

  String result="Hey!";

  Future _scanQR() async{
    try{
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result= qrResult;
      });
    }on PlatformException catch(e){
      if(e.code== BarcodeScanner.CameraAccessDenied){
        setState(() {
          result="CameraAccessDenied ";
        });
      }
      else{
        setState(() {
          result = "Unknown Error $e";
        });
      }
    }catch(e) {
      setState(() {
        result = "Unknown Error $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.orange,
        ),
        title:Text('Back',style: TextStyle(color: Colors.orange,fontSize: 20.0),) ,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Consumer<CardCounter>(
            builder: (context, counter, child) => FlatButton(
              onPressed: () {
                Navigator.pop(context);
                counter.addCard(CardInfo(
                  cardController.value.text,
                  cardTypeController.value.text,
                  cardRemarkController.value.text,
                ));
              },
              child: Text('Save',style: TextStyle(color: Colors.orange),),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          // card input
          TextField(
            controller: cardController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              icon: Icon(Icons.credit_card),
              labelText: 'Please enter you cardID',
            ),
            autofocus: false,
          ),
          //card type input
          TextField(
            controller: cardTypeController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              icon: Icon(Icons.calendar_view_day),
              labelText: 'Please enter your cardtype',
            ),
            autofocus: false,
          ),
          TextField(
            controller: cardRemarkController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              icon: Icon(Icons.rate_review),
              labelText: 'Please enter you card remark',
            ),
            autofocus: false,
          ),
          RaisedButton(
            child: Text(
              'Use Camera',
              style: TextStyle(fontSize: 20.0),

            ),
            color: Colors.orange,
            colorBrightness: Brightness.dark,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.grey,
            padding: new EdgeInsets.only(
              bottom: 5.0,
              top: 5.0,
              left: 20.0,
              right: 20.0,
            ),
            onPressed: _scanQR,

              shape: RoundedRectangleBorder(
                side: new BorderSide(
                  width: 2.0,
                  color: Colors.white,
                  style: BorderStyle.solid,
                ),

                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              )
          )
        ],
      ),
      bottomNavigationBar: TabBar(

        tabs: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.066,
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.topCenter,
            child: Image(
              image: AssetImage("assets/backgrounds/tabCard.png"),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.topCenter,
            height: MediaQuery.of(context).size.height * 0.066,
            child: Image(
              image: AssetImage("assets/backgrounds/tabUser.png"),
            ),
          )
        ],
      ),

    );
  }
}
