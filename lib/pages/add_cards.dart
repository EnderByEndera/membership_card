import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class AddCardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddCardState();
  }
}

class AddCardState extends State<AddCardPage> {



  @override
  Widget build(BuildContext context) {
    //Todo: implement invoking camera
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title:Container(
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


      body: new ListView(
           children: <Widget>[
             SizedBox(height: 20.0),
             ListTile(
             leading:
             Image( image: AssetImage("assets/buttons/btnAddNewCard.png"),
               fit: BoxFit.fitHeight, height: 50.0,width: 80.0 ,),

               title: Text('Other card',style:TextStyle(color:Colors.black) ,),
               onTap: (){
               Navigator.pushNamed(context, "/addnumber");
               },

             ),
             SizedBox(height: 20.0),

            Container(
              color: Colors.deepOrange,
               child: ListTile(
                 title: Text('FREQUENTLY ADDED'),
               ),

             ),

             SizedBox(height: 20.0),

             ListTile(
               leading:CircleAvatar(
                 backgroundImage: NetworkImage('https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2424866418,3761545187&fm=26&gp=0.jpg'),
                 radius: 35.0,
               ),

//
               title: Text('Starbucks',style:TextStyle(color:Colors.black,fontSize: 15.0) ,),
               dense: true,
               onTap: (){
                 Navigator.of(context).pushNamed( "/addnumber" ,arguments: {"store":'starbucks'});
               },
             ),


             new Padding(
                 padding: EdgeInsets.all(8.0),
                 child: new Divider()
             ),


             ListTile(
               leading:CircleAvatar(
                 backgroundImage: NetworkImage('https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2433869611,3143457223&fm=26&gp=0.jpg'),
                 radius: 35.0,
               ),

//
               title: Text('McDonald',style:TextStyle(color:Colors.black,fontSize: 15.0) ,),
               dense: true,
               onTap: (){
                 Navigator.of(context).pushNamed( "/addnumber" ,arguments: {"store":'McDonald'});
               },
             ),


             new Padding(
                 padding: EdgeInsets.all(8.0),
                 child: new Divider()
             ),


             ListTile(
               leading:CircleAvatar(
                 backgroundImage: NetworkImage('https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=4018677965,3937180888&fm=26&gp=0.jpg'),
                 radius: 35.0,
               ),

//
               title: Text('HP',style:TextStyle(color:Colors.black,fontSize: 15.0) ,),
               dense: true,
               onTap: (){
                 Navigator.of(context).pushNamed( "/addnumber" ,arguments: {"store":'HP'});
               },
             ),
             new Padding(
                 padding: EdgeInsets.all(8.0),
                 child: new Divider()
             ),


             ListTile(
               leading:CircleAvatar(
                 backgroundImage: NetworkImage('https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1592200203721&di=8d227c12a08d5e10502f23a526f0bd6a&imgtype=0&src=http%3A%2F%2Fimg.mp.itc.cn%2Fupload%2F20160504%2Fcc297d7d29f9418f929569f57170cd64_th.jpg'),
                 radius: 35.0,
               ),

//
               title: Text('BurgerKing',style:TextStyle(color:Colors.black,fontSize: 15.0) ,),
               dense: true,
               onTap: (){
                 Navigator.of(context).pushNamed( "/addnumber" ,arguments: {"store":'BurgerKing'});
               },
             ),
             new Padding(
                 padding: EdgeInsets.all(8.0),
                 child: new Divider()
             ),


           ],
      ),


    );
  }
}




