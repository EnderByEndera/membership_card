import 'package:dio/dio.dart';
///This page is the edit_card page
///which used to edit the information of a card
///it provide the delete function
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:membership_card/model/card_count.dart';
import 'package:membership_card/model/card_model.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:membership_card/network/client.dart';
import 'package:membership_card/model/user_model.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:membership_card/network/cookie.dart';

class EditCardPage extends StatefulWidget{
  final String cardId;
  final String eName;
  EditCardPage(this.cardId, this.eName);
  @override
  State<StatefulWidget> createState() => EditCardPageState(this.cardId, this.eName);
}

class EditCardPageState extends  State<EditCardPage>
  with TickerProviderStateMixin {

  final String cardId;
  final String eName;
  EditCardPageState(this.cardId, this.eName);

  TabController _tabController;

 Dio dio=initDio();
  Future<Response> res1;
  Future<Response> res2;
  //final CardInfo card;
   //EditCardPageState(this.card) ;

  ///card control
  TextEditingController cardController = TextEditingController();

  ///card type control
  TextEditingController cardStoreController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );

    cardController.text = cardId;
    cardStoreController.text = eName;

  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  GlobalKey _formKey = GlobalKey<FormState>();
  @override


  Widget build(BuildContext context){
    dynamic args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
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
          FlatButton(
              onPressed: () async{
               if((_formKey.currentState as FormState).validate()) {
                try {
                  dio.interceptors.add(CookieManager(await Api.cookieJar));
                  dioModify(dio,cardController.text,cardStoreController.text,cardId).then((res) async{
                    print(res.statusCode);
                    print(res.data);
                    if(res.statusCode==200) {
                      Navigator.pop(context);
                      Provider.of<CardCounter>(context, listen: false).editCard(
                          args["card"],
                          cardController.value.text,
                          cardStoreController.value.text);
                      print(res.statusCode);
                    }else {
                      showDialog(
                          context: context,
                          builder: (_) =>
                              AlertDialog(
                                title: Text("Alert"),
                                content: Text("Failed to edit a card!"),
                              ));
                    }
                  }
                  );
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
                  fontSize: 25.0,),
              ),
            ),

        ],
      ),

      body:ListView(
        children:<Widget>[
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {

          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Form(
          key: _formKey,
          autovalidate: true,

          child: Column(
            children: <Widget>[
              Text("Enter the store name and the customer number for your card",textAlign: TextAlign.center,maxLines: 1,style:
              TextStyle(
                  color: Colors.orange
              ),),

              TextFormField(
                controller: cardController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  icon: Icon(Icons.credit_card),
                  labelText: 'Please edit you cardNumber',
                ),
                //limit MAX input=20
                inputFormatters:[WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),LengthLimitingTextInputFormatter(20)] ,
                validator: (value) {// 校验用户名
                  return value.trim().length > 0 ? null : 'Card Number can not be null';
                },
                autofocus: false,
              ),

              TextFormField(
                controller: cardStoreController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  icon: Icon(Icons.calendar_view_day),
                  labelText: 'Please edit the storeName',
                ),
                //limit MAX input=20
                inputFormatters:[WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9_\u4e00-\u9fa5]")),LengthLimitingTextInputFormatter(20)] ,
                validator: (value) {// 校验用户名
                  return value.trim().length > 0 ? null : 'Store Name can not be null';
                },
                autofocus: false,
              ),


              SizedBox(height: 200.0,),

              Stack(
               alignment: Alignment.bottomCenter,
                children:<Widget>[

                Positioned(

                  child:Consumer<CardCounter>(
                   builder: (context, counter, child) =>FlatButton(
                     child: Text(
                'Delete Card',
                style: TextStyle(fontSize: 20.0,color:Colors.orange
                ),
              ),
              color: Colors.transparent,
              colorBrightness: Brightness.dark,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.grey,
              padding: new EdgeInsets.only(
                bottom: 5.0,
                top: 5.0,
                left: 20.0,
                right: 20.0,
              ),
              onPressed: () async{
                try {
                  dio.interceptors.add(CookieManager(await Api.cookieJar));
                  dioDelete(cardId, dio).then((res) async{
                    Navigator.of(context).popAndPushNamed('/allCardsPage');
                    counter.deleteCard(args["card"]);
                    print(res.statusCode);
                  });
                }catch(e){
                  print(e);
                }
              },
              shape: RoundedRectangleBorder(
                side: new BorderSide(
                  width: 2.0,
                  color: Colors.transparent,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
            ),

          ),
        ),
            ],
         ),
          ],
              ),

          ),
      ),

      ],
      ),
      //here


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