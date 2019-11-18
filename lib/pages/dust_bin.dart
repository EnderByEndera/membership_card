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
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
          )

      ),
      body: Center(

      ),

    );
  }
}
