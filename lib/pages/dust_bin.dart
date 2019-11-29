import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:barcode_flutter/barcode_flutter.dart';

class DustBinPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return DustBinState();
  }
}


class DustBinState extends State<DustBinPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back ),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.orange,

          ),
         title: Text("Back"),
      ),
      body: new Column(
        children: <Widget>[
           Text(
               "Recycle Bin",
               style:TextStyle(
                 fontSize: 25.0,
                 color: Colors.orange,
                 height: 132.9,
               ),
           ),

          Image(
            image: AssetImage("assets/images/Bin.png"),
            height: 200.0,
            width: 150.0,
          ),
          BottomNavigationWidget(),
        ],
      )


    );
  }
}



class BottomNavigationWidget extends StatefulWidget {
  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}


class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final _BottomNavigationColor = Colors.orange;
  int _currentIndex = 0;
  List<Widget> list = List();

  @override
  void initState() {
    //list
      //..add(CardScreen())
     // ..add(PersonScreen());
    super.initState(); //无名无参需要调用
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //脚手架
      body: list[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.credit_card,
                color: _BottomNavigationColor,
              ),
              title: Text(
                'Card',
                style: TextStyle(color: _BottomNavigationColor),
              )),

          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: _BottomNavigationColor,
              ),
              title: Text(
                'Me',
                style: TextStyle(color: _BottomNavigationColor),
              )),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}