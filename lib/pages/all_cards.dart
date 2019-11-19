import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:membership_card/model/card_count.dart';
import 'package:membership_card/model/card_model.dart';
import 'package:membership_card/network/client.dart';
import 'package:membership_card/pages/add_cards_with_camera.dart';
import 'package:membership_card/pages/add_cards_with_number.dart';
import 'package:membership_card/pages/card_info.dart';
import 'package:membership_card/pages/help.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

/// This is the All_Cards Page [AllCardsPage] which is the home of the App.
/// It shows all the cards users created and users can also add cards
/// in this page. Every Card is called [CardInfo].
/// One page showed four cards, every card has its information including
/// [CardInfo.cardId], [CardInfo.cardType], [CardInfo.remark]
/// When users click one card, it will go into the [CardInfoPage] which
/// contains all detailed information one card has.
/// Moreover, on the top-left users can click menu button to get [HelpPage]
/// which contains all the information about how this app works.
/// Add function is divided into two parts: [AddCardWithCameraPage] and
/// [AddCardWithNumberPage]. [AddCardWithCameraPage] uses camera API to read
/// cardNumber through bar code, while [AddCardWithNumberPage] needs user to
/// write the cardNumber on his/her own.
class AllCardsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AllCardsPageState();
  }
}

/// This is the state related to the [AllCardsPage]
/// It is the main state of the [AllCardsPage]
class AllCardsPageState extends State<AllCardsPage> {
  // These are the network variables for network connection
  Response res;
  Dio dio = initDio();

  Widget _buildList(BuildContext context, int index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Consumer<CardCounter>(
            builder: (context, counter, child) => Hero(
              tag: counter.cardList.elementAt(index).cardKey,
              child: SizedBox(
                height: 137.1,
                child: GestureDetector(
                  onTap: () {
                    var cardInfo = counter.cardList.elementAt(index);
                    Navigator.of(context).pushNamed("/cardinfo", arguments: {
                      "cardId": cardInfo.cardId,
                      "cardType": cardInfo.cardType,
                      "remark": cardInfo.remark,
                      "key": cardInfo.cardKey,
                    });
                  },
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/images/anz_card.png"),
                      fit: BoxFit.fitHeight,
                    )),
                    child: Text(
                      "${counter.cardList.elementAt(index).cardType}\n" +
                          "${counter.cardList.elementAt(index).cardId}",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "consolas",
                          fontSize: 28.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget _getCardBagAppBar() {
    return SliverAppBar(
      elevation: 16.0,
      expandedHeight: MediaQuery.of(context).size.height * 300 / 1920,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(left: 6, bottom: 30),
        title: Text(
          "Card bag",
          style: TextStyle(
            fontFamily: "msyh",
            fontSize: 32.0,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        //Todo: AppBar may be updated in the future, but now we don't do this

        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.black,
          child: PopupMenuButton(
            icon: Icon(
              Icons.add,
              size: 48.0,
            ),
            padding: EdgeInsets.all(0),
            itemBuilder: (context) => <PopupMenuEntry<String>>[
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.text_fields),
                  title: Text("Manual"),
                ),
                value: "manual",
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.camera),
                  title: Text("Camera"),
                ),
                value: "camera",
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.help),
                  title: Text("Help"),
                ),
                value: "help",
              )
            ],
            onSelected: (value) {
              switch (value) {
                case "manual":
                  Navigator.of(context).pushNamed("/addnumber");
                  break;
                case "camera":
                  Navigator.of(context).pushNamed("/addcamera");
                  break;
                case "help":
                  Navigator.of(context).pushNamed("/help");
                  break;
              }
            },
          ),
        ),
        body: FutureBuilder(
          future: dioGet("/api/user", dio),
          builder: (context, AsyncSnapshot<Response> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<dynamic> _list = jsonDecode(snapshot.data.data);
              var _cardList = List<CardInfo>();
              if (_list != null) {
                for (var value in _list) {
                  _cardList.add(CardInfo.fromJson(value));
                }
              }
              Provider.of<CardCounter>(context).cardList = _cardList;
              return CustomScrollView(
                slivers: <Widget>[
                  _getCardBagAppBar(),
                  Consumer<CardCounter>(builder: (context, counter, child) {
                    return SliverList(
                        delegate: SliverChildBuilderDelegate(
                      _buildList,
                      childCount: counter.cardList.length,
                    ));
                  }),
                ],
              );
            } else {
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
