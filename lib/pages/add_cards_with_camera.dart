import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class AddCardWithCameraPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddCardWithCameraState();
  }
}

class AddCardWithCameraState extends State<AddCardWithCameraPage> {
 String result="Hey!";

 Future _scanQR() async{
   try{
     String qrResult = await BarcodeScanner.scan();
     setState(() {
       result= qrResult;
     });
   }on PlatformException catch(e){
     if(e.code== BarcodeScanner.CameraAccessDenied){
       setState(() {
         result="CameraAccessDenied ";
       });
     }
     else{
       setState(() {
         result = "Unknown Error $e";
       });
     }
   }catch(e) {
     setState(() {
       result = "Unknown Error $e";
     });
   }
 }

  @override
  Widget build(BuildContext context) {
    //Todo: implement invoking camera

    return Scaffold(
        appBar: AppBar(
         leading: IconButton(
           icon:Icon(Icons.arrow_back_ios,color: Colors.orange,),
              onPressed: (){
                   Navigator.pop(context);
         }
        )

        ),

        body: new Column(
           children: <Widget>[
            RaisedButton(
                onPressed :_scanQR,
            )
           ],
    ) ,
    );
  }
}


