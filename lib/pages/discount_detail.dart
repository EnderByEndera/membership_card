import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class discountDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return discountDetailPageState();
  }
}

class discountDetailPageState extends State<discountDetailPage> {

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
//        title: ListTile(
//          leading: GestureDetector(
//            onTap: () {
//              Navigator.pop(context);
//            },
//            child: Container(
//              child: Padding(
//                padding: const EdgeInsets.all(0),
//                child: Text(
//                  "< Back",
//                  style: TextStyle(
//                    decoration: TextDecoration.none,
//                    fontSize: 25.0,
//                    color: Theme.of(context).primaryColor,
//                    fontWeight: FontWeight.w500,
//                  ),
//                ),
//              ),
//            ),
//          ),
//          title: Text(
//            args["enterprise"],
//            style: TextStyle(
//              decoration: TextDecoration.none,
//              fontSize: 25.0,
//              fontWeight: FontWeight.w500,
//            ),
//          ),
//        ),
        title:GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
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
            ),
          ),
      ),
      body: Builder(
          builder: (context) =>
              ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Image(
                          image: AssetImage("assets/backgrounds/starbucksBackground.jpg"),   //card.background
                          //height: 300,
                          fit: BoxFit.fitWidth,
                        ),
                        ListTile(
                          title: Text(
//                            args["title"],
                            "discount 50%",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 25, color: Color.fromARGB(255, 119, 136, 213), fontWeight: FontWeight.w700 ),
                          ),
                        ),
                        Card(
                          elevation: 10.0,
                          margin: new EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                          color: Color.fromARGB(0, 255, 255, 255),
                          child: new Container(
                            width: 400.0,
                            height: 200.0,
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              image: new DecorationImage(
                                  image: new AssetImage("assets/coupon/coffee.png"),
                                  fit: BoxFit.contain),
                              shape: BoxShape.rectangle, // <-- 这里需要设置为 rectangle
                              borderRadius: new BorderRadius.all(
                                const Radius.circular(
                                    15.0), // <-- rectangle 时，BorderRadius 才有效
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(8, 20, 8, 0),
                          child: Text(
//                            args["describe"],
                            "use while buying hp's laptop",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        RaisedButton(
                          color: Colors.blue,
                          highlightColor: Colors.blue[700],
                          colorBrightness: Brightness.dark,
                          splashColor: Colors.grey,
                          child: Text('领取', style: TextStyle(fontSize: 16)),
//              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          onPressed: () => getDialog(context),
                        ),
                      ],
                    ),
                  ),
                ],
              )
      ),
    );
  }

  void getDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder:(_) => AlertDialog(
            content: Text('确认领取优惠券?'),
//            title: Center(
//                child: Text(
//                  '您将会回到登陆页面',
//                  style: TextStyle(
//                      color: Colors.black,
//                      fontSize: 20.0,
//                      fontWeight: FontWeight.bold),
//                )),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Scaffold.of(context).showSnackBar(new SnackBar(
                      content: new Text("优惠券领取成功"),
                    ));
                    Navigator.of(context).pop();
                    ///****************************有待补充***************************//
                    ///**************************************************************//
                  },
                  child: Text('是')),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('否')),
            ],
          ));

  }
}