import 'dart:io';

import 'package:dio/dio.dart';
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
import 'package:membership_card/network/client.dart';
import 'package:membership_card/model/user_model.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:membership_card/network/cookie.dart';

class AddCardWithNumberPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddCardWithNumberPageState();
}

class AddCardWithNumberPageState extends State<AddCardWithNumberPage>
    with TickerProviderStateMixin {
   TabController _tabController;
   Dio dio=initDio();
   Response res;


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
  TextEditingController cardIdController = TextEditingController();

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
 String cameraId;
  String cameraEname;

  GlobalKey _formKey = GlobalKey<FormState>();
  @override



  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title:Container(
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
          Consumer<CardCounter>(
            builder: (context, counter, child) => FlatButton(
              onPressed: () async{
                if((_formKey.currentState as FormState).validate()) {
            try {

              dio.interceptors.add(CookieManager(await Api.cookieJar));

              dioAdd(dio, cardIdController.value.text, cardStoreController.value.text).then((res) async{
                if(res.statusCode==200) {
                  //获取cookies
                  List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse(dio.options.baseUrl+"/v1/api/user/login"));
                  print(cookies);
                  print("Load cookies successly");
                  //Save cookies
                  //(await Api.cookieJar).saveFromResponse(res.request.uri, cookies.map((str) => Cookie.fromSetCookieValue(str.toString())).toList());
                  //print("Save cookies successly");
                  Navigator.pop(context);
                  counter.addCard(CardInfo(
                    cardIdController.value.text,
                    cardStoreController.value.text,
                  ));
                  print(res.statusCode);
                }else {
                  showDialog(
                      context: context,
                      builder: (_) =>
                          AlertDialog(
                            title: Text("Alert"),
                            content: Text("Failed to add a card!"),
                          ));
                  print(res.statusCode);
                }
              });

            }catch(e){
              print(e);
            }
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
      body: ListView(
        children:<Widget>[
        GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {

          FocusScope.of(context).requestFocus(FocusNode());
        },
        child:Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              // card input
              TextFormField(
                controller: cardIdController,
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

              SizedBox(height: 200.0,),

              FutureBuilder(

                builder: (context,snapshot) {
                  if (snapshot.hasData) {
                  Map card=snapshot.data;
                  cameraId=card["_cardId"];
                  cameraEname=card["_eName"];
                  }

                    return RaisedButton(
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
                    );
                }
              )
            ],
          ),
        ),

      ),


      ],
      ),
      //here
    );
  }
}