import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:membership_card/network/client.dart';
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
import 'package:membership_card/model/activity_model.dart';
import 'package:membership_card/model/activity_count.dart';
class ActivityinfoPage extends StatefulWidget {
  @override
  ActivityinfoState createState() {
    return ActivityinfoState();
  }
}

class ActivityinfoState extends State<ActivityinfoPage> {
  static List _imageUrls = [
    'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1892437343,3193213548&fm=26&gp=0.jpg'
  ];

  Response res;
  Dio dio = initDio();
  var list=[];
  var my=[];
  int index;


  @override
  void initState() {
    super.initState();
      dioGetActivity(dio).then((res) async {
        print(res.statusCode);
        print(res.data);
        List<dynamic> js = res.data['activity'];
        print(js);
        List<ActivityInfo> mylist = ActivityCounter.fromJson(js).activityList;
        int i = 0;
        print(mylist);
        var b=[];
        for (; i < mylist.length; i++) {

          ActivityInfo a = mylist[i];
          b.add(a.description);

        }
        setState(() {
          list = b;
          my=mylist;
        });
        print(list);

      });


    }



  getList() {
    Iterable<Widget> listTitles;
int i=0;
       listTitles = list.map((dynamic item) {

        print(item);
        return new ListTile(
          isThreeLine: true,
          dense: false,

          leading: new CircleAvatar(child: new Text((i+1).toString())),
          title: new Text('卡片类型'),
          subtitle: new Text(item),
          trailing: new Icon(Icons.arrow_right, color: Colors.green),
          onTap: () {
            print(i);
            print(my);
            Navigator.of(context).popAndPushNamed('/discountDetail',arguments:{"CardType":my[i].type,"Enterprise":my[i].enterprise,
            "Coupons":my[i].coupons,"Describe":my[i].description,"ExpireTime":my[i].expireTime,"Id":my[i].activityId,
            });
          },


        );

      });

    i=i+1;
      return listTitles.toList();
  }


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
              height: MediaQuery.of(context).size.height * 0.37,
              alignment: Alignment(0.5, 0),
              child: Image(
                image: AssetImage("assets/backgrounds/starbucksBackground.jpg"),
              )),


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






/*
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
*/


}
