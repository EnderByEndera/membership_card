import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:membership_card/pages/add_cards_with_camera.dart';
import 'package:membership_card/pages/all_cards.dart';
import 'package:membership_card/model/card_count.dart';
import 'package:membership_card/pages/help.dart';
import 'package:membership_card/pages/search.dart';
import 'package:membership_card/pages/settings.dart';
import 'package:provider/provider.dart';

import 'model/card_model.dart';
import 'pages/add_cards_with_number.dart';
import 'pages/card_info.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(GoWallet());
  });
}

/// This is the entrance of our GoWallet App.
/// It is used for entering the whole GoWallet App and
///  all the routes are set here.
/// Maybe in the future we need to do the state management here.
///  if the state changed so quickly that we have to do the
///  global state management
class GoWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

        // This is the providers for out state management
        providers: [
          ChangeNotifierProvider(builder: (context) => CardCounter()),
          ChangeNotifierProvider(
            builder: (context) => CardInfo(),
          )
        ],
        child: MaterialApp(
          title: 'GoWallet App',
          home: AllCardsPage(),
          theme: ThemeData.light(),

          // routes defined all the page routes of our App
          routes: {
            "/addnumber": (_) => AddCardWithNumberPage(),
            "/addcamera": (_) => AddCardWithCameraPage(),
            "/cardinfo": (_) => CardInfoPage(),
            "/settings": (_) => SettingsPage(),
            "/search": (_) => SearchPage(),
            "/help": (_) => HelpPage(),
          },
        ));
  }
}
