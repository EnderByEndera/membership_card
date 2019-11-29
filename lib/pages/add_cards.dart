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
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:Icon(Icons.arrow_back_ios,color: Colors.orange,),
          onPressed: (){
            Navigator.pop(context);
          }
        ),
        title:Text('Back',style: TextStyle(color: Colors.orange,fontSize: 20.0),) ,
      ),
      body: new ListView(
           children: <Widget>[
             ListTile(
             leading: Image( image: AssetImage("assets/images/btnAddNewCard.png"),
               fit: BoxFit.fitWidth,),
               title: Text('Other card',style:TextStyle(color:Colors.grey) ,),
               onTap: (){
               Navigator.pushNamed(context, "/addnumber");

               },
             ),
            Container(
              color: Colors.grey,
               child: ListTile(
                 title: Text('FREQUENTLY ADDED'),
               ),

             ),
             ListTile(
               leading:Image.network('https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1296785508,2723653490&fm=26&gp=0.jpg',
                 fit: BoxFit.fitWidth,),
               title: Text('Card 1',style:TextStyle(color:Colors.black) ,),
               dense: true,
             ),
             new Padding(
                 padding: EdgeInsets.all(8.0),
                 child: new Divider()
             ),
             ListTile(
               leading:Image.network('https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1296785508,2723653490&fm=26&gp=0.jpg',
                 fit: BoxFit.fitWidth,),
               title: Text('Card 2',style:TextStyle(color:Colors.black) ,),
               dense: true,
               isThreeLine: false,

             ),
             new Padding(
                 padding: EdgeInsets.all(8.0),
                 child: new Divider()
             ),
             ListTile(
               leading:Image.network('https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1296785508,2723653490&fm=26&gp=0.jpg',
                 fit: BoxFit.fitWidth,),
               title: Text('Card 3',style:TextStyle(color:Colors.black) ,),
               dense: true,
             ),
             new Padding(
                 padding: EdgeInsets.all(8.0),
                 child: new Divider()
             ),
             ListTile(
               leading:Image.network('https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1296785508,2723653490&fm=26&gp=0.jpg',
                 fit: BoxFit.fitWidth,),
               title: Text('Card 4',style:TextStyle(color:Colors.black) ,),
               dense: true,
             ),
             new Padding(
                 padding: EdgeInsets.all(8.0),
                 child: new Divider()
             ),
             ListTile(
               leading:Image.network('https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1296785508,2723653490&fm=26&gp=0.jpg',
                 fit: BoxFit.fitWidth,),
               title: Text('Card 5',style:TextStyle(color:Colors.black) ,),
               dense: true,
             ),

           ],
      ),

      bottomNavigationBar: TabBar(

        tabs: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.066,
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.topCenter,
            child: Image(
              image: AssetImage("assets/backgrounds/tabCard.png"),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.topCenter,
            height: MediaQuery.of(context).size.height * 0.066,
            child: Image(
              image: AssetImage("assets/backgrounds/tabUser.png"),
            ),
          )
        ],
      ),
    );
  }
}




