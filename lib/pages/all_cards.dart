import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:membership_card/model/card_count.dart';
import 'package:membership_card/model/card_model.dart';
import 'package:membership_card/pages/add_cards_with_camera.dart';
import 'package:membership_card/pages/add_cards_with_number.dart';
import 'package:membership_card/pages/card_info.dart';
import 'package:membership_card/pages/help.dart';
import 'package:provider/provider.dart';

/// This is the All_Cards Page [AllCardsMainPage] which is the home of the App.
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
class AllCardsMainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AllCardsMainPageState();
  }
}

/// This is the state related to the [AllCardsMainPage]
/// It is the main state of the [AllCardsMainPage]
class AllCardsMainPageState extends State<AllCardsMainPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int _cardNumber = Provider.of<CardCounter>(context).cardList.length;
    Widget _randomColorContainer = Container(
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(offset: Offset.zero, blurRadius: 5.0)],
          border: Border.all(color: Colors.grey, width: 1.5),
          borderRadius: BorderRadius.circular(12.0),
          color: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),
              Random().nextInt(256), Random().nextDouble())),
      height: MediaQuery.of(context).size.height / 10,
      width: MediaQuery.of(context).size.height / 10 / 0.9 * 1.6,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Puntos",
          style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: 32.0,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image(
                image: AssetImage("assets/buttons/btnAdd.png"),
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed("/addcamera");
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage("assets/backgrounds/nfcIllu.jpg"),
            alignment: Alignment.topCenter,
          ),
        ),
        alignment: Alignment.center,
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.7,
            ),
            Container(
              alignment: Alignment.center,
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/addnumber");
                },
                child: Image(
                  width: MediaQuery.of(context).size.width / 3,
                  image: AssetImage("assets/buttons/btnPunch.png"),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "Press ",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: "\'Punch\' ",
                          style: TextStyle(
                            color: Color.fromRGBO(251, 107, 0, 70),
                          )),
                      TextSpan(text: "button and hold your phone close to "),
                      TextSpan(
                          text: "Punch Reward ",
                          style: TextStyle(
                            color: Color.fromRGBO(251, 107, 0, 70),
                          )),
                      TextSpan(text: "in the "),
                      TextSpan(
                          text: "shop",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          )),
                      TextSpan(text: " to receive discounts")
                    ]),
              ),
            ),
            Spacer(),
            _cardNumber == 0
                ? Flex(direction: Axis.vertical, children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Manage other membership cards",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 10,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed("/addcamera");
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey, width: 1.5),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                height: MediaQuery.of(context).size.height / 10,
                                width: MediaQuery.of(context).size.height /
                                    10 /
                                    0.9 *
                                    1.6,
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Image(
                                    image:
                                        AssetImage("assets/buttons/btnAdd.png"),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return _randomColorContainer;
                          }
                        },
                      ),
                    )
                  ])
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => AllCardsPage()));
                      },
                      child: Consumer<CardCounter>(
                        builder: (context, counter, child) => Stack(
                          fit: StackFit.loose,
                          children: <Widget>[
                            Hero(
                              tag: 'first',
                              child: Container(
                                height: MediaQuery.of(context).size.height / 4,
                                alignment: Alignment(0, -1),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(
                                        color: Colors.yellow, width: 1.5),
                                    color: Colors.yellow,
                                  ),
                                  width: 160 * 1.5,
                                  height: 90 * 1.5,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                            Hero(
                              tag: 'second',
                              child: Container(
                                height: MediaQuery.of(context).size.height / 4,
                                alignment: Alignment(0, -0.3),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(
                                        color: Colors.blue, width: 1.5),
                                    color: Colors.blue,
                                  ),
                                  width: 160 * 1.5,
                                  height: 90 * 1.5,
                                ),
                              ),
                            ),
                            Hero(
                              tag: 'third',
                              child: Container(
                                height: MediaQuery.of(context).size.height / 4,
                                alignment: Alignment(0, 0.3),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(
                                        color: Colors.purple, width: 1.5),
                                    color: Colors.purple,
                                  ),
                                  width: 160 * 1.5,
                                  height: 90 * 1.5,
                                ),
                              ),
                            ),
                            Hero(
                              tag: 'fourth',
                              child: Container(
                                height: MediaQuery.of(context).size.height / 4,
                                alignment: Alignment(0, 1),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(
                                        color: Colors.green, width: 1.5),
                                    color: Colors.green,
                                  ),
                                  width: 160 * 1.5,
                                  height: 90 * 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        tabs: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 15,
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.topCenter,
            child: Image(
              image: AssetImage("assets/backgrounds/tabCard.png"),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.topCenter,
            height: MediaQuery.of(context).size.height / 15,
            child: Image(
              image: AssetImage("assets/backgrounds/tabUser.png"),
            ),
          )
        ],
      ),
    );
  }
}

class AllCardsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AllCardsPageState();
  }
}

class _AllCardsPageState extends State<AllCardsPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          padding: EdgeInsets.all(4.0),
          iconSize: 32.0,
          icon: Icon(
            Icons.arrow_back,
            color: Color.fromRGBO(251, 107, 0, 70),
          ),
        ),
        title: Text(
          "Puntos",
          style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: 32.0,
            color: Color.fromRGBO(251, 107, 0, 70),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image(
                image: AssetImage("assets/buttons/btnAdd.png"),
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed("/addcamera");
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(itemBuilder: (context, index) {
          if (index == 0) {
            return Hero(
              tag: "first",
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.yellow, width: 1.5),
                  color: Colors.yellow,
                ),
                constraints: BoxConstraints(minHeight: 150),
              ),
            );
          } else if (index == 1) {
            return Hero(
              tag: 'second',
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.blue, width: 1.5),
                  color: Colors.blue,
                ),
                constraints: BoxConstraints(minHeight: 150),
              ),
            );
          } else if (index == 2) {
            return Hero(
              tag: 'third',
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.purple, width: 1.5),
                  color: Colors.purple,
                ),
                constraints: BoxConstraints(minHeight: 150),
              ),
            );
          } else if (index == 3) {
            return Hero(
              tag: 'fourth',
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.green, width: 1.5),
                  color: Colors.green,
                ),
                constraints: BoxConstraints(minHeight: 150),
              ),
            );
          } else {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: Colors.amber, width: 1.5),
                color: Colors.amber,
              ),
              constraints: BoxConstraints(minHeight: 150),
            );
          }
        }),
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        tabs: <Widget>[
          Hero(
            tag: 'tab one',
            child: Container(
              height: MediaQuery.of(context).size.height / 15,
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.topCenter,
              child: Image(
                image: AssetImage("assets/backgrounds/tabCard.png"),
              ),
            ),
          ),
          Hero(
            tag: 'tab two',
            child: Container(
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height / 15,
              child: Image(
                image: AssetImage("assets/backgrounds/tabUser.png"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
