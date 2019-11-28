///This page is the add card page.
///The user can jump to this page by clicking the Add button in the main page, and enter the user's card number,
///card type and card notes here. After adding, click the back button
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:membership_card/model/card_count.dart';
import 'package:membership_card/model/card_model.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
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
          Consumer<CardCounter>(
            builder: (context, counter, child) => RaisedButton(
              onPressed: () {
                Navigator.pop(context);
                counter.addCard(CardInfo(
                  cardController.value.text,
                  cardTypeController.value.text,
                  cardRemarkController.value.text,
                ));
              },
              child: Text('Add and return'),
            ),
          ),
        ],
      ),
    );
  }
}
