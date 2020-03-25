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

class AddCardWithNumberPageState extends State<AddCardWithNumberPage>
    with TickerProviderStateMixin {
  TabController _tabController;

  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  ///card control
  TextEditingController cardController = TextEditingController();

  ///card type control
  TextEditingController cardStoreController = TextEditingController();



  String result="Hey!";

  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "CameraAccessDenied ";
        });
      } else {
        setState(() {
          result = "Unknown Error $e";
        });
      }
    } catch (e) {
      setState(() {
        result = "Unknown Error $e";
      });
    }
  }

  GlobalKey _formKey = GlobalKey<FormState>();
  @override



  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Container(
          child: GestureDetector(
            child: Text(
              "﹤Back",
              style: TextStyle(

                decoration: TextDecoration.none,
                fontSize: 25.0,
                color: Theme.of(context).primaryColor,
                //fontWeight: FontWeight.bold,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),

        actions: <Widget>[
          Consumer<CardCounter>(
            builder: (context, counter, child) => FlatButton(
              onPressed: () {
                if((_formKey.currentState as FormState).validate()) {
                  Navigator.pop(context);
                  counter.addCard(CardInfo(
                    cardController.value.text,
                    cardStoreController.value.text,

                  ));
                }

              },
              child: Text(
                'Save',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 25.0,
                  ),
              ),
            ),
          ),
        ],
      ),
      body:
          GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () {

    FocusScope.of(context).requestFocus(FocusNode());
    },
    child:
      Form(
        key: _formKey,
        autovalidate: true,
        child: Column(
        children: <Widget>[
          // card input
          TextFormField(
            controller: cardController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              icon: Icon(Icons.credit_card),
              labelText: 'Please enter you cardNumber',
            ),
            //limit MAX input=20
            inputFormatters:[WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),LengthLimitingTextInputFormatter(20)] ,
            validator: (value) {// 校验用户名
              return value.trim().length > 0 ? null : 'Card Number can not be null';
            },

            autofocus: false,
          ),
          //card type input
          TextFormField(
            controller: cardStoreController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              icon: Icon(Icons.calendar_view_day),
              labelText: 'Please enter the storeName',
            ),
              //limit MAX input=20
            inputFormatters:[WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9_\u4e00-\u9fa5]")),LengthLimitingTextInputFormatter(20)] ,
            validator: (value) {// 校验用户名
              return value.trim().length > 0 ? null : 'Store Name can not be null';
            },
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
      ),
          ),



      bottomNavigationBar: TabBar(
        controller: _tabController,
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