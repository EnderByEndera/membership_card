import 'package:flutter/material.dart';
import 'package:membership_card/pages/all_cards.dart';
import 'package:membership_card/pages/user_info.dart';
import 'package:membership_card/model/user_model.dart';
import 'package:membership_card/pages/store_list.dart';
import 'package:membership_card/pages/ActivityinfoPage.dart';

class BottomMenuPage extends StatefulWidget {
  @override
  BottomMenuPageState createState() => BottomMenuPageState();
}
 int _currentIndex = 0;  //设置当前显示的页面索引

class BottomMenuPageState extends State<BottomMenuPage>
    with SingleTickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    dynamic args = ModalRoute.of(context).settings.arguments;
    User user = args["user"];
    List<Widget> viewList = [AllCardsMainPage(), SwiperPage(), UserInfoPage(user)];

    return Container(
      child: Scaffold(
        body: viewList[_currentIndex],
        bottomNavigationBar: SafeArea(
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Image.asset("assets/backgrounds/tabCard.png",height: 28),
                title: Text("My Cards",style: TextStyle(color: Colors.blue),),
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.local_activity, size: 36,),
                title: Text("Activity",style: TextStyle(color: Colors.blue),),
              ),

              BottomNavigationBarItem(
                icon: Image.asset("assets/backgrounds/tabUser.png",height: 28),
                title: Text("Account",style: TextStyle(color: Colors.blue),),
              ),
            ],

            currentIndex: _currentIndex,

            type: BottomNavigationBarType.fixed,//设置类型

            //设置点击响应
            onTap: (int index){         //参数设置为默认的index，这个index就是点击的按钮的index
              setState(() {
                _currentIndex =index;
              });
            },
          ),
        ),
      ),
    );

  }
}