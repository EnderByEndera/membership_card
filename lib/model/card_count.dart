import 'package:flutter/material.dart';
import 'package:membership_card/model/card_model.dart';
import 'package:membership_card/pages/edit_card.dart';

class CardCounter extends ChangeNotifier {
  //static const String CARDS_JSON = "data";

  List<CardInfo> _cardList = new List<CardInfo>();
  CardCounter(this._cardList);

  set cardList(List<CardInfo> value) {
    _cardList = value;
    notifyListeners();
  } //default constructor

  List<CardInfo> get cardList => _cardList;

  void addCard(CardInfo cardInfo) {
    _cardList.add(cardInfo);
    notifyListeners();
  }

  void deleteCard(CardInfo cardInfo) {
    bool isRemoved = _cardList.remove(cardInfo);
    if (!isRemoved) throw "Card Remove failed";
    notifyListeners();
  }

  CardInfo getOneCard(int index) {
    return _cardList.elementAt(index);
  }

  CardInfo getCard(CardInfo card) {
    return card;
  }

//  void chooseOneCard(int index) {
//    if (index < _cardList.length) {
//      _cardList.elementAt(index).chooseOrNotChoose();
//      notifyListeners();
//    }
//  }

  void editCard(CardInfo cardInfo, String number, String store){
    cardInfo.cardId = number;
    cardInfo.eName = store;
    notifyListeners();
  }

  Color getCardColor(int index) {
    return _cardList.elementAt(index).cardColor;
  }

  CardCounter.fromJson(List<dynamic> json){

    List<CardInfo> list=[];
    for(int i=0; i<json.length; i++){
      list.add(CardInfo.fromJson(json[i]));
    }

    /*json.forEach((f){
      list.add(CardInfo.fromJson(f));
    });*/
    _cardList = list;
  }
}