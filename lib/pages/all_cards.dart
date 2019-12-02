import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  ScrollController _scrollController;

  NfcData response = new NfcData(content: "");

  void _intoNFC() async {
    showDialog(
      context: context,
      builder: (_) => Container(
        child: Flex(
          direction: Axis.vertical,
          children: [
            GestureDetector(
              onTap: () async {
                Navigator.of(context).pop();
                response = await FlutterNfcReader.stop();
                print(response.content);
              },
              child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  alignment: Alignment.center,
                  child: Text(
                    response.content,
                    style: TextStyle(
                        fontSize: 16.0, decoration: TextDecoration.none),
                  )),
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 3.0)],
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white),
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Spacer(
                      flex: 52,
                    ),
                    Expanded(
                      flex: 70,
                      child: Container(
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
                    ),
                    Expanded(
                      flex: 310,
                      child: Container(
                        height: 200,
                        child: Image(
                          image: AssetImage("assets/backgrounds/nfcIllu.jpg"),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 50,
                      child: Container(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                            text: "Hold your phone near the fire",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(flex: 60),
                    Expanded(
                      flex: 106,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey,
                        ),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: MaterialButton(
                            onPressed: () async {
                              try {
                                Navigator.of(context).pop();
                                response = await FlutterNfcReader.stop();
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
                    ),
                    Spacer(flex: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    try {
      response = await FlutterNfcReader.read();
      print("content: ${response.content} "
          "status: ${response.status.toString()} "
          "error: ${response.error}");
      Navigator.of(context).pop();
//      Navigator.of(context).popAndPushNamed("/cardinfo");
    } on Exception {
      Navigator.of(context).pop();
      showDialog(context: context, builder: (_) => _nfcAlertDialog());
    }
  }

  AlertDialog _nfcAlertDialog() {
    return AlertDialog(
      title: Text("NFC Not Found"),
      content: Text("Please open NFC in your phone first"),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            _intoNFC();
          },
          child: Text("already done",
              style: TextStyle(color: Theme.of(context).primaryColor)),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "Cancel",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        )
      ],
    );
  }

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
        border: Border.all(color: Colors.grey, width: 1.5),
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
          image: AssetImage('assets/backgrounds/starbucksBackground.jpg'),
          fit: BoxFit.fitWidth,
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: MediaQuery.of(context).size.height / 10,
      width: MediaQuery.of(context).size.height / 10 / 0.9 * 1.6,
    );

    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context, _cardNumber, _randomColorContainer),
      bottomNavigationBar: buildTabBar(context, _tabController),
    );
  }

  static TabBar buildTabBar(BuildContext context, TabController tabController) {
    return TabBar(
      controller: tabController,
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
    );
  }

  SafeArea buildBody(
      BuildContext context, int _cardNumber, Widget _randomColorContainer) {
    return SafeArea(
      minimum: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        alignment: Alignment.center,
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Spacer(flex: 30),
            Expanded(
              flex: 250,
              child: Container(
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage("assets/backgrounds/nfcIllu.jpg"),
                ),
              ),
            ),
            Expanded(
              flex: 40,
              child: Container(
                alignment: Alignment.center,
                child: MaterialButton(
                  onPressed: _intoNFC,
                  child: Image(
                    width: MediaQuery.of(context).size.width * 0.33,
                    image: AssetImage("assets/buttons/btnPunch.png"),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 80,
              child: Container(
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
            ),
            Spacer(
              flex: 10,
            ),
            Expanded(
              flex: 130,
              child: _cardNumber == 0
                  ? Flex(direction: Axis.vertical, children: <Widget>[
                      Expanded(
                        flex: 10,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Manage other membership cards",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 4,
                      ),
                      Expanded(
                        flex: 17,
                        child: Container(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed("/addnumber");
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey, width: 1.5),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    width: MediaQuery.of(context).size.height *
                                        0.1 /
                                        0.9 *
                                        1.6,
                                    child: Padding(
                                      padding: const EdgeInsets.all(24.0),
                                      child: Image(
                                        image: AssetImage(
                                            "assets/buttons/btnAdd.png"),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return _randomColorContainer;
                              }
                            },
                          ),
                        ),
                      )
                    ])
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: GestureDetector(
                        onVerticalDragEnd: (details) {
                          if (details.primaryVelocity <= 0) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => AllCardsPage()));
                          }
                        },
                        child: Consumer<CardCounter>(
                          builder: (context, counter, child) => Stack(
                              fit: StackFit.expand,
                              children: _buildStack(
                                  counter.cardList.length > 4
                                      ? 4
                                      : counter.cardList.length,
                                  context)),
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  static AppBar buildAppBar(BuildContext context) {
    return AppBar(
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

            ///We can test page here
          },
        )
      ],
    );
  }

  List<Widget> _buildStack(int number, BuildContext context) {
    var heroList = List<Widget>();
    for (int heroNumber = 0; heroNumber < number; heroNumber++) {
      heroList.add(Consumer<CardCounter>(
        builder: (context, counter, child) => Hero(
          tag: counter.getOneCard(heroNumber).cardKey,
          flightShuttleBuilder:
              (context, animation, direction, fromHeroContext, toHeroContext) {
            return Container(
              decoration: BoxDecoration(
                color: counter.getCardColor(heroNumber),
                borderRadius: BorderRadius.circular(10.0),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(
                top: heroNumber * 8.0,
                left: 12 - heroNumber * 4.0,
                right: 12 - heroNumber * 4.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: counter.getCardColor(heroNumber),
              ),
            ),
          ),
        ),
      ));
    }
    return heroList;
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
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
//    _textEditingController.addListener(() => null);
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    _scrollController = ScrollController(
      keepScrollOffset: true,
    );
  }

  @override
  void dispose() {
//    _textEditingController.dispose();
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NotificationListener<OverscrollNotification>(
          onNotification: (notification) {
            if (notification.dragDetails?.delta?.dy != null &&
                notification.dragDetails.delta.dy > 20) {
              Navigator.of(context).pop();
              return true;
            } else {
              return false;
            }
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
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
                      if (index.isOdd) {
                        int heroNumber = index ~/ 2;
                        return Consumer<CardCounter>(
                          builder: (context, counter, _) => Hero(
                            tag: counter.getOneCard(heroNumber).cardKey,
                            child:
                                _buildMembership(counter, heroNumber, context),
                          ),
                        );
                      } else {
                        return Divider(
                          height: 5,
                        );
                      }
                    },
                    childCount:
                        Provider.of<CardCounter>(context).cardList.length * 2,
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar:
            AllCardsMainPageState.buildTabBar(context, _tabController));
  }

  static Widget _buildMembership(
      CardCounter counter, int heroNumber, BuildContext context) {
    return Consumer<CardCounter>(
      builder: (context, counter, _) => GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed("/cardinfo", arguments: {
            "herotag": counter.getOneCard(heroNumber).cardKey,
            "cardId": counter.getOneCard(heroNumber).cardId,
            "eName": counter.getOneCard(heroNumber).eName,
            "cardType": counter.getOneCard(heroNumber).cardType,
          });
        },
        child: Container(
          decoration: BoxDecoration(
              color: counter.getCardColor(heroNumber),
              borderRadius: BorderRadius.circular(10.0)),
          constraints: BoxConstraints(minHeight: 150),
          child: Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(16.0),
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.0),
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  padding: EdgeInsets.all(8.0),
                  child:
                      Text(counter.getOneCard(heroNumber).cardCoupon.toString(),
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          )),
                ),
              ),
              Container(
                margin: EdgeInsets.all(16.0),
                alignment: Alignment.topLeft,
                child: Text(
                  counter.getOneCard(heroNumber).eName,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(16.0),
                alignment: Alignment(-1.0, -0.3),
                child: Text(
                  "Buy 5 Get 1 Free",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.all(16.0),
                  alignment: Alignment(-1, 0.1),
                  child: Text("Offer expires at 31/12/2019",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ))),
              Container(
                  margin: EdgeInsets.all(16.0),
                  alignment: Alignment(-1, 0.6),
                  child: Text(
                      "${5 - counter.getOneCard(heroNumber).cardCoupon} "
                      "More to go",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
              Container(
                height: 30,
                child: ListView(
                  padding: EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 115.0, bottom: 2.0),
                  scrollDirection: Axis.horizontal,
                  children: _buildRewardPlace(heroNumber, 6, context),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static List<Widget> _buildRewardPlace(
      int heroNumber, int number, BuildContext context) {
    var rewardList = List<Widget>();
    for (int i = 1; i <= number; i++) {
      rewardList.add(Container(
        constraints: BoxConstraints.tightFor(
            height: 33.0,
            width: (MediaQuery.of(context).size.width - 64.0) / 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
        ),
        alignment: Alignment.center,
        child: i >
                Provider.of<CardCounter>(context)
                    .getOneCard(heroNumber)
                    .cardCoupon
            ? Text(i.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ))
            : Image(
                image: AssetImage("assets/points/Polygon.png"),
              ),
      ));
    }
    return rewardList;
  }
}
