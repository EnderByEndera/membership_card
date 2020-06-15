import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:membership_card/model/card_count.dart';
import 'package:membership_card/model/card_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:membership_card/network/client.dart';
import 'package:membership_card/model/user_model.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:membership_card/network/cookie.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperPage extends StatefulWidget {
  @override
  SwiperPageState createState() {
    return SwiperPageState();
  }
}

class SwiperPageState extends State<SwiperPage> {
 static List _imageUrls = [
    'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1892437343,3193213548&fm=26&gp=0.jpg',
    'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1700718690,9797066&fm=26&gp=0.jpg',
    'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2774630792,60701066&fm=26&gp=0.jpg',
    'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=837235093,3732460301&fm=26&gp=0.jpg',
  ];

 Dio dio=initDio();
 Response res1;



 var numList =['a','b','c','d'];

 getList() {
   Iterable<Widget> listTitles = numList.map((String item) {
     return new ListTile(
       isThreeLine: true,
       dense: false,
       leading: new CircleAvatar(child: new Text(item)),
       title: new Text(item),
       subtitle: new Text('item 的内容'),
       trailing: new Icon(Icons.arrow_right, color: Colors.green),
     );
   });
   return listTitles.toList();
 }



// void initState() {
//   //页面初始化
//   super.initState();
//   dioGetActivities(dio).then((res1) async{
//     if(res1.statusCode==200){
//       List<dynamic> js = res1.data;
//       List<CardInfo> list = CardCounter.fromJson(js).cardList;
//       numList=list;
//     }
//   } );
// }


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Container(
          child: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Text(
                "< Back",
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 25.0,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: ListView(
          children:<Widget>[
             Container(
            width: MediaQuery.of(context).size.width,
            height: 200.0,
                child: _swiper),

            SizedBox(height: 30,),

            new ListView(
              children: this.getList(),
              shrinkWrap: true, // 添加
              physics: NeverScrollableScrollPhysics(),
            )
          ],
      ),

    );
  }














  var _swiper=new Swiper
    (
    itemBuilder: (BuildContext context, int index) {
        return (
            Image.network(_imageUrls[index], fit: BoxFit.fill,)
        );
      },
    itemCount:_imageUrls.length ,
    pagination: new SwiperPagination(
        builder: DotSwiperPaginationBuilder(
          color: Colors.black54,
          activeColor: Colors.deepOrange,
        )),
    viewportFraction: 0.8,
    scale: 0.9,
    control: new SwiperControl(),
    scrollDirection: Axis.horizontal,
    autoplay: true,
    onTap: (index) => print('点击了第$index个'),
  );



}
