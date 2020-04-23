import 'package:flutter/material.dart';
import 'package:membership_card/model/card_model.dart';
import 'package:membership_card/pages/edit_card.dart';

class CardCounter extends ChangeNotifier {
  //static const String CARDS_JSON = "data";

  List<CardInfo> _cardList = new List<CardInfo>();
  CardCounter(this._cardList);   //default constructor

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

  void chooseOneCard(int index) {
    if (index < _cardList.length) {
      _cardList.elementAt(index).chooseOrNotChoose();
      notifyListeners();
    }
  }

  void editCard(CardInfo cardInfo, String number, String store){
    cardInfo.setCardId(number);
    cardInfo.setCardStore(store);
    notifyListeners();
  }

  Color getCardColor(int index) {
    return _cardList.elementAt(index).cardColor;
  }

  CardCounter.fromJson(List<dynamic> json){
    _cardList = json.map((i)=>CardInfo.fromJson(i)).toList();
  }
}