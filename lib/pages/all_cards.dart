import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
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

  var _dots = List<TextSpan>();

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
    var _cardNumber = Provider.of<CardCounter>(context).cardList.length;

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
              Navigator.of(context).pushNamed("/addnumber");
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
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (_) => Container(
                      child: Flex(
                        direction: Axis.vertical,
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [BoxShadow(blurRadius: 3.0)],
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.white),
                              child: Flex(
                                direction: Axis.vertical,
                                children: <Widget>[
                                  SizedBox(height: 20),
                                  Container(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      "Ready to Scan",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 28.0,
                                        decoration: TextDecoration.none,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Container(
                                    height: 200,
                                    child: Image(
                                      image: AssetImage(
                                          "assets/backgrounds/nfcIllu.jpg"),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Hold your phone near the fire",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          decoration: TextDecoration.none,
                                        ),
                                        children: _dots,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey,
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: 50,
                                    child: MaterialButton(
                                        onPressed: () async {
                                          try {
                                            Navigator.of(context).pop();
                                            NfcData response =
                                                await FlutterNfcReader.stop();
                                            print(response.content);
                                          } on Exception {
                                            Navigator.of(context).pop();
                                          }
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(fontSize: 20.0),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                  try {
                    NfcData response = await FlutterNfcReader.read();
                    print(response.content);
                    Navigator.of(context).popAndPushNamed("/cardinfo");
                  } on Exception {
                    Navigator.of(context).pop();
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text("NFC Not Found"),
                              content:
                                  Text("Please open NFC in your phone first"),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("already done",
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor)),
                                )
                              ],
                            ));
                  }
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
                            color: Theme.of(context).primaryColor,
                          )),
                      TextSpan(text: "button and hold your phone close to "),
                      TextSpan(
                          text: "Punch Reward ",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
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
                                Navigator.of(context).pushNamed("/addnumber");
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
                      onVerticalDragEnd: (details) {
                        if (details.primaryVelocity <= 0) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => AllCardsPage()));
                        }
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
  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
//    _textEditingController.addListener(() => null);
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
//    _textEditingController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          bottom: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              automaticallyImplyLeading: false,
              leading: null,
              title: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                    hintText: "SEARCH...",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
              )),
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            padding: EdgeInsets.all(4.0),
            iconSize: 32.0,
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColor,
            ),
          ),
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
                Navigator.of(context).pushNamed("/addnumber");
              },
            )
          ],
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == 0) {
                  return Hero(
                    tag: "first",
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(color: Colors.white, width: 3),
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
                        border: Border.all(color: Colors.white, width: 3),
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
                        border: Border.all(color: Colors.white, width: 3),
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
                        border: Border.all(color: Colors.white, width: 3),
                        color: Colors.green,
                      ),
                      constraints: BoxConstraints(minHeight: 150),
                    ),
                  );
                } else {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.white, width: 3),
                      color: Colors.amber,
                    ),
                    constraints: BoxConstraints(minHeight: 150),
                  );
                }
              },
            ),
          ),
        ),
      ]),
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
