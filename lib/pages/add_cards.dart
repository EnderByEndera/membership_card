
import 'package:flutter/material.dart';

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
               Navigator.pushNamed(context, "/addcamera");

               },
             ),
            Container(
              color: Colors.grey,
               child: ListTile(
                 title: Text('FREQUENTLY ADDED'),
               ),

             ),
             ListTile(
               leading:Image(image: AssetImage("assets/images/btnAddNewCard.png"),
    fit: BoxFit.fitWidth,),
               title: Text('Card 1',style:TextStyle(color:Colors.black) ,),
             ),
             new Padding(
                 padding: EdgeInsets.all(8.0),
                 child: new Divider()
             ),
             ListTile(
               leading:Image(image: AssetImage("assets/images/btnAddNewCard.png"),
                 fit: BoxFit.fitWidth,),
               title: Text('Card 2',style:TextStyle(color:Colors.black) ,),
             ),
             new Padding(
                 padding: EdgeInsets.all(8.0),
                 child: new Divider()
             ),
             ListTile(
               leading:Image(image: AssetImage("assets/images/btnAddNewCard.png"),
                 fit: BoxFit.fitWidth,),
               title: Text('Card 3',style:TextStyle(color:Colors.black) ,),

             ),
             new Padding(
                 padding: EdgeInsets.all(8.0),
                 child: new Divider()
             ),
             ListTile(
               leading:Image(image: AssetImage("assets/images/btnAddNewCard.png"),
                 fit: BoxFit.fitWidth,),
               title: Text('Card 4',style:TextStyle(color:Colors.black) ,),
             ),
             new Padding(
                 padding: EdgeInsets.all(8.0),
                 child: new Divider()
             ),
             ListTile(
               leading:Image(image: AssetImage("assets/images/btnAddNewCard.png"),
                 fit: BoxFit.fitWidth,),
               title: Text('Card 5',style:TextStyle(color:Colors.black) ,),

             ),

           ],
      ),
    );
  }
}