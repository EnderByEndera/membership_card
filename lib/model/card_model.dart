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
//  static const String MAX_COUPON_JSON  = "max_coupon";
  static const String COUPON_NUM_JSON = "CouponsNum";
//  static const String ADDRESS_JSON     = "address";
  static const String BATCH_NUM_JSON   = "BatchNum";
  static const String CARD_ID_JSON     = "CardId";
  static const String CARD_TYPE_JSON     = "CardType";
  static const String TYPE_ID_JSON     = "TypeId";
  static const String CITY_JSON        = "City";
//  static const String DESCRIPTION_JSON = "description";
  static const String E_NAME_JSON      = "Enterprise";
  static const String FACTORY_NUM_JSON = "FactoryNum";
//  static const String REMARK_JSON      = "remark";
//  static const String STYLE_JSON       = "style";
  static const String TEL_JSON         = "tel";
  static const String TYPE_JSON        = "type";
  static const String USER_ID_JSON     = "UserId";
//  static const String WORK_TIME_JSON   = "work_time";
//  static const String BACKGROUND_JSON  = "background";
//  static const String ICON_JSON        = "icon";
  static const String EXPIRE_TIME_JSON = "ExpireTime";
  static const String CURRENT_SCORE_JSON = "Score";
//  static const String MAX_SCORE_JSON     = "max_score";
  static const String CARD_ORDER_JSON     = "CardOrder";
  static const String COUPONS_JSON     = "Coupons";
  static const String START_TIME_JSON     = "StartTime";
  static const String DEL_TIME_JSON     = "DelTime";
  static const String MONEY_JSON     = "Money";
  static const String SERIAL_NUM_JSON     = "SerialNum";
  static const String STATE_JSON     = "State";
  static const String USE_TIMES_JSON     = "UseTimes";
  static const String DISCOUNT_TIMES_JSON     = "DiscountTimes";


  int _useTimes;
  int _discountTimes;
  int _currentScore;
  int _couponsNum;
  //int    _maxCoupon = _currentScore ~/ _maxCoupon;
  int _maxCoupon;
//  String _address;
  int _batchNum;
  String _cardId;
  String _cardType;
  int _typeId;
  String _city;
//  String _description;
  String _eName;
  String _expireTime;
  int _factoryNum;
//  String _remark;
//  String _style;
//  String _tel;
//  String _type;
  String _userId;
//  String _workTime;
//  Image  _background;
//  Image  _icon;
  int _cardOrder;
  String _coupons;
  String _delTime;
  String _startTime;
  int _money;
  int _serialNum;
  String _state;
//  bool _isChosen = false;
  Key _cardKey = UniqueKey();
  Color _cardColor = Color.fromARGB(255, Random().nextInt(255),
      Random().nextInt(255), Random().nextInt(255));

  String get cardId      => _cardId;
  String get cardType    => _cardType;
//  String get remark      => _remark;
  Key    get cardKey     => _cardKey;
  int get batchNum    => _batchNum;
  String get city        => _city;
  int get factoryNum  => _factoryNum;
//  String get style       => _style;
//  String get type        => _type;
  String get userId      => _userId;
  String get eName       => _eName;
//  bool   get isChosen    => _isChosen;
  Color  get cardColor   => _cardColor;
  int    get couponsNum  => _couponsNum;
  int    get maxCoupon   => _maxCoupon;
//  String get address     => _address;
//  String get description => _description;
//  String get tel         => _tel;
//  String get workTime    => _workTime;
  String get expireTime  => _expireTime;
  String get startTime => _startTime;
  int    get currentScore=> _currentScore;
  int get cardOrder => _cardOrder;
  String  get coupons => _coupons;
  String get delTime => _delTime;
  int get money => _money;
  int get serialNum => _serialNum;
  String get state => _state;

  int    get discountTimes    => _discountTimes;
  int get useTimes => _useTimes;

  int get typeId => _typeId;

  set typeId(int value) {
    _typeId = value;
  }

  set useTimes(int value) {
    _useTimes = value;
  }

  set cardId(String value) {
    _cardId = value;
    notifyListeners();
  }

  set eName(String value) {
    _eName = value;
    notifyListeners();
  }

  set startTime(String value) {
    _startTime = value;
  }
//  set isChosen(bool isChosen){
//    this._isChosen = isChosen;
//    notifyListeners();
//  }

    void addScore(int score) {
      if (this._currentScore <= 5)
        this._currentScore = score;
      else this._currentScore = 0;
    }

    void redeemCoupon() {
      this._couponsNum--;
      notifyListeners();
    }

    CardInfo([this._cardId, this._eName]);

    CardInfo.fromJson(Map<String, dynamic> json) {
      this._cardId = json[CARD_ID_JSON];
      this._eName = json[E_NAME_JSON];
      ///this._remark = json[REMARK_JSON];
      this._currentScore = json[CURRENT_SCORE_JSON];
      this._expireTime = json[EXPIRE_TIME_JSON];
      this._couponsNum = json[COUPON_NUM_JSON];
      this._userId = json[USER_ID_JSON];
      this._city = json[CITY_JSON];
      this._batchNum = json[BATCH_NUM_JSON];
      this._cardType = json[CARD_TYPE_JSON];
      this._factoryNum = json[FACTORY_NUM_JSON];
      this._cardOrder = json[CARD_ORDER_JSON];
      this._coupons = json[COUPONS_JSON];//.cast<String>();
      this._delTime = json[DEL_TIME_JSON];//cast<String>();
      this._money = json[MONEY_JSON];
      this._serialNum = json[SERIAL_NUM_JSON];
      this._state = json[STATE_JSON];
      this..startTime = json[START_TIME_JSON];
      this.useTimes = json[USE_TIMES_JSON];
      this._discountTimes = json[DISCOUNT_TIMES_JSON];
      this._typeId = json[TYPE_ID_JSON];
    }

    factory CardInfo.getJson(Map<String, dynamic> json) {
      return CardInfo(json[CARD_ID_JSON],json[E_NAME_JSON]);
    }

    Map<String, dynamic> toJson() => {
      CARD_ID_JSON   : cardId,
      E_NAME_JSON : cardType,
    };

    Map<String, dynamic> idToJson()=>{
      CARD_ID_JSON : cardId,
    };


//    void chooseOrNotChoose() {
//      _isChosen = _isChosen? false : true;
//    }
  }



