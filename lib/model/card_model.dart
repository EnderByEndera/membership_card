import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:membership_card/pages/all_cards.dart';


/// This is the class defining all the card info
/// It is generally used in [AllCardsState] and [AllCardsMainPage]
/// [CardInfo] CONSTRUCTOR ORDER is {[_cardId], [_eName], [_remark]}
/// ```dart
/// // This is the basic CardInfo constructing method
/// // ATTENTION for the order of the constructor params!!!
/// CardInfo cardInfo = CardInfo(cardId, cardType, remark);
/// ```
///
/// Moreover, you can create one CardInfo using [Map] created by [JsonDecoder]
/// ```dart
/// var jsonDecoder = JsonDecoder();
/// CardInfo cardInfo = CardInfo.fromJson(jsonDecoder.convert(jsonInput));
/// ```
class CardInfo extends ChangeNotifier{
  static const String CARD_ID_JSON     = "id";
  static const String E_NAME_JSON      = "e_name";
  static const String REMARK_JSON      = "remark";
  static const String BATCH_NUM_JSON   = "batch_num";
  static const String CITY_JSON        = "city";
  static const String FACTORY_NUM_JSON = "factory_num";
  static const String STYLE_JSON       = "style";
  static const String TYPE_JSON        = "style";
  static const String USER_ID_JSON     = "user_id";

  String _cardId;
  String _eName;
  String _remark;
  String _batchNum;
  String _city;
  String _factoryNum;
  String _style;
  String _type;
  String _userId;
  int    _cardCoupon = 3;

  bool _isChosen = false;
  Key _cardKey = UniqueKey();
  Color _cardColor = Color.fromARGB(255, Random().nextInt(255),
      Random().nextInt(255), Random().nextInt(255));

  String get cardId     => _cardId;
  String get cardType   => _eName;
  String get remark     => _remark;
  Key    get cardKey    => _cardKey;
  String get batchNum   => _batchNum;
  String get city       => _city;
  String get factoryNum => _factoryNum;
  String get style      => _style;
  String get type       => _type;
  String get userId     => _userId;
  String get eName      => _eName;
  bool   get isChosen   => _isChosen;
  Color  get cardColor  => _cardColor;
  int    get cardCoupon => _cardCoupon;

  set isChosen(bool isChosen) => this._isChosen = isChosen;

  CardInfo([this._cardId, this._eName, this._remark]);

  CardInfo.fromJson(Map<String, dynamic> json) {
    this._cardId = json[CARD_ID_JSON];
    this._eName = json[E_NAME_JSON];
    this._remark = json[REMARK_JSON];
  }

  factory CardInfo.getJson(Map<String, dynamic> json) {
    return CardInfo(json[CARD_ID_JSON], json[REMARK_JSON], json[E_NAME_JSON]);
  }

  Map<String, dynamic> toJson() => {
    CARD_ID_JSON   : cardId,
    E_NAME_JSON : cardType,
    REMARK_JSON    : remark,
  };


  void chooseOrNotChoose() {
    _isChosen = _isChosen? false : true;
  }
}