import 'package:flutter/material.dart';
import 'package:barcode_flutter/barcode_flutter.dart';
/// This is the Card_Info Page showing one card's information.
/// It should include one card's all the information here.
class CardInfoPage extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return CardInfoState();
  }
}

class CardInfoState extends State<CardInfoPage> {

static var image1;
static var flatButton1;
static var wrap1;


  List<Widget> items = [image1,flatButton1,wrap1];

  //删除方法，判断item长度>=3的时候可以删除 ，根据需求自行定义，
  //给子组件调用
  void deleteFirstTitle() {
    if(items.length>=1) {
      setState(() {
        items.removeAt(0);
      });
    }

  }




  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
        //Todo: Add more UI for App bar from here

        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list),color: Colors.black,onPressed: () { showDialog(//弹出框
              barrierDismissible: true,//是否点击空白区域关闭对话框,默认为true，可以关闭
              context: context,
              builder: (BuildContext context) {
                var list = List();
                list.add('编辑');
                list.add('删除');

                return CommonBottomSheet(
                    list: list,
                    onItemClickListener: (index) async {
                      Navigator.pop(context);
                    },
                    deleteItem: deleteFirstTitle
                );
              });}),
        ],// Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.


      ),
      //Todo: Add more UI about Card Info body from here
      body: new Column(
        children: <Widget>[
          image1=Image(
            image: AssetImage("assets/images/anz_card.png"),
            fit: BoxFit.fitWidth,
            height: 150.0,
          ),
         flatButton1= FlatButton(
          shape: BeveledRectangleBorder(
            side: BorderSide(
            color: Colors.black,
            width: 0.6,
            ),
          ),

            child: Text(
              "barcode",
              style: TextStyle(
              color: Colors.black45,
              ),
            ),
          hoverColor: Colors.red,
            onPressed: () {_openBarCodePage(args["cardId"]);},
          ),
         wrap1= Wrap(
            spacing: 90.0,        // 主轴(水平)方向间距
            runSpacing: 4.0,      // 纵轴（垂直）方向间距
            alignment: WrapAlignment.center, //沿主轴方向居中
            children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Integral",
                  style: TextStyle(
                    height: 3.0,
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "500",
                  style: TextStyle(
                    height: 2.0,
                    fontSize: 20.0,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Coupons",
                  style: TextStyle(
                    height: 3.0,
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "0",
                  style: TextStyle(
                    height: 2.0,
                    fontSize: 20.0,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
              Text(
                "NUM:"+args["cardId"],
                style: TextStyle(
                  height: 3.0,
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
          ],
          ),


        ],


      ),
    );
  }

  void _openBarCodePage(String cardNumberData){
    Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (BuildContext context){
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.black,
            ),
            title: Text(
              "Barcode",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          body: new Center(
            child: new BarCodeImage(
              data: cardNumberData,
              codeType: BarCodeType.Code128,
              barHeight: 120.0,
              hasText: true,
              onError: (error){
                print('error=$error');
              },
            ),
          ),
        );
      }
    )
    );
  }
}




class CommonBottomSheet extends StatefulWidget {

  CommonBottomSheet({Key key, this.list, this.onItemClickListener,@required this.deleteItem})
      : assert(list != null),
        super(key: key);
  final list;
  final OnItemClickListener onItemClickListener;
  final deleteItem;

  @override
  _CommonBottomSheetState createState() => _CommonBottomSheetState();
}
typedef OnItemClickListener = void Function(int index);

class _CommonBottomSheetState extends State<CommonBottomSheet> {
  OnItemClickListener onItemClickListener;
  var itemCount;
  double itemHeight = 44;
  var borderColor = Colors.white;
  double circular = 10;

  @override
  void initState() {
    super.initState();
    onItemClickListener = widget.onItemClickListener;
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery
        .of(context)
        .orientation;
    Size screenSize = MediaQuery
        .of(context)
        .size;

    var deviceWidth = orientation == Orientation.portrait
        ? screenSize.width
        : screenSize.height;
    print('devide width');
    print(deviceWidth);

    /// *2-1是为了加分割线，最后还有一个cancel，所以加1
    itemCount = (widget.list.length * 2 - 1) + 1;
    var height = ((widget.list.length + 1) * 48).toDouble();
    var cancelContainer = Container(
        height: itemHeight,
        margin: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.white, // 底色
          borderRadius: BorderRadius.circular(circular),
        ),
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context); //点击取消时弹回主界面
            },
            child: Text("取消",
              style: TextStyle(
                  fontFamily: 'Robot',
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  color: Color(0xff333333),
                  fontSize: 18),
            ),
          ),
        ));
    var listview = ListView.builder(
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          if (index == itemCount - 1) {
            return new Container(
              child: cancelContainer,
              margin: const EdgeInsets.only(top: 10),
            );
          }
          return getItemContainer(context, index);
        });

    var totalContainer = Container(
      child: listview,
      height: height,
      width: deviceWidth * 0.98,
    );

    var stack = Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          bottom: 0,
          child: totalContainer,
        ),
      ],
    );
    return stack;
  }
  Widget getItemContainer(BuildContext context, int index) {
    if (widget.list == null) {
      return Container();
    }
    if (index.isOdd) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Divider(
          height: 0.5,
          color: borderColor,
        ),
      );
    }

    var borderRadius;
    var margin;
    var border;
    var borderAll = Border.all(color: borderColor, width: 0.5);
    var borderSide = BorderSide(color: borderColor, width: 0.5);
    var isFirst = false;
    var isLast = false;

    /// 只有一个元素
    if (widget.list.length == 1) {
      borderRadius = BorderRadius.circular(circular);
      margin = EdgeInsets.only(bottom: 10, left: 10, right: 10);
      border = borderAll;
    } else if (widget.list.length > 1) {
      /// 第一个元素
      if (index == 0) {
        isFirst = true;
        borderRadius = BorderRadius.only(topLeft: Radius.circular(circular),
            topRight: Radius.circular(circular));
        margin = EdgeInsets.only(left: 10, right: 10,);
        border = Border(top: borderSide, left: borderSide, right: borderSide);
      } else if (index == itemCount - 2) {
        isLast = true;

        /// 最后一个元素
        borderRadius = BorderRadius.only(bottomLeft: Radius.circular(circular),
            bottomRight: Radius.circular(circular));
        margin = EdgeInsets.only(left: 10, right: 10);
        border =
            Border(bottom: borderSide, left: borderSide, right: borderSide);
      } else {
        /// 其他位置元素
        margin = EdgeInsets.only(left: 10, right: 10);
        border = Border(left: borderSide, right: borderSide);
      }
    }
    var isFirstOrLast = isFirst || isLast;
    int listIndex = index ~/ 2;
    var text = widget.list[listIndex];
    var contentText = Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.normal,
          decoration: TextDecoration.none,
          color: Color(0xFF333333),
          fontSize: 18),
    );

    var center;
    if (!isFirstOrLast) {
      center = Center(
        child: contentText,
      );
    }
    var itemContainer = Container(
        height: itemHeight,
        margin: margin,
        decoration: BoxDecoration(
          color: Colors.white, // 底色
          borderRadius: borderRadius,
          border: border,
        ),
        child: center);
    var onTap2 = () {
      showAlertDialog(context);
    };

    var stack = Stack(
      alignment: Alignment.center,
      children: <Widget>[itemContainer, contentText],
    );
    var getsture = GestureDetector(
      onTap: onTap2,
      child: isFirstOrLast ? stack : itemContainer,
    );
    return getsture;
  }

  void showAlertDialog(BuildContext context) {  // 对话框函数
    NavigatorState navigator= context.rootAncestorStateOfType(const TypeMatcher<NavigatorState>());
    debugPrint("navigator is null?"+(navigator==null).toString());


    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
            title: new Text("Delete"),
            content: new Text("Click 'delete' to confirm the deletion."),
            actions:<Widget>[
              new FlatButton(child:new Text("CANCEL"), onPressed: (){
                Navigator.of(context).pop();

              },),
              new FlatButton(child:new Text("DELETE"), onPressed: (){
                //删除body第一个
                //思路：将 list 保存在数组中，删除数组第一个，更新数据即可
                //删除方法定义在父组件中，传递给子组件
                widget.deleteItem();
                //关闭dialog
                Navigator.of(context).pop();
                //关闭bottomSheet
                widget.onItemClickListener(2);
              },
              )
            ]
        ));
  }
}

