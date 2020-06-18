import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:membership_card/control/remember_account/remember_account.dart';
import 'package:membership_card/model/user_model.dart';
import 'package:membership_card/network/client.dart';
import 'package:provider/provider.dart';
import 'package:membership_card/model/card_model.dart';
import 'package:membership_card/model/card_count.dart';
import 'package:membership_card/model/user_count.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:membership_card/network/cookie.dart';
import 'package:membership_card/model/enterprise_count.dart';
import 'package:membership_card/model/enterprise_model.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  GlobalKey _globalKey = new GlobalKey(); //用来标记控件

  var _passwordController;
  var _accountController;

  bool _isSent = false;
  bool _accountCorrect = false;
  bool _passwordCorrect = false;
  String _loginMsg;
  String _accountErrMsg;
  String _passwordErrMsg;
  String _username = "";
  String _password = "";
  bool _remember = false;
  bool _isTel;
  bool _isMail;
  bool _expand = false; //是否展示历史账号
  User user = new User();
  UserCounter _userCounter = new UserCounter(); //历史账号

  Dio dio = initDio();
  Response res1;
  Response res2;

  @override
  void dispose() {
    _passwordController.dispose();
    _accountController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initController();
    _gainUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: <Widget>[
            Center(
              child: Container(
                width: 300,
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Icon(
                          Icons.card_membership,
                          size: 50,
                        ),
                      ),
                    ),
                    _buildUsername(),
                    _buildPassword(),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: _remember,
                          activeColor: Colors.red, //选中时的颜色
                          onChanged: (value) {
                            setState(() {
                              _remember = value;
                            });
                          },
                        ),
                        Text("Remember Password"),
                      ],
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/forgetPage");
                            },
                            child: Text("Forget password?",
                                style: TextStyle(
                                    color: Colors.grey,
                                    decoration: TextDecoration.underline)),
                          )
                        ],
                      ),
                    ),
                    _buildButton(),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 20),
                        alignment: AlignmentDirectional.bottomCenter,
                        child: Text("Version: 1.0.0"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Offstage(
              child: _buildListView(),
              offstage: !_expand,
            ),
          ],
        ));
  }

  ///构建账号输入框
  Widget _buildUsername() {
    return TextField(
      key: _globalKey,
      decoration: InputDecoration(
        labelText: "Account",
        errorText: _accountErrMsg,
        border: OutlineInputBorder(borderSide: BorderSide()),
        contentPadding: EdgeInsets.all(8),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Icon(Icons.person_outline),
        suffixIcon: GestureDetector(
          onTap: () {
            print(_userCounter.length);
            setState(() {
              _expand = !_expand;
            });
            print(_expand);
          },
          child: _expand
              ? Icon(
                  Icons.arrow_drop_up,
                  color: Colors.red,
                )
              : Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
        ),
      ),
      maxLength: 24,
      controller: _accountController,
      onChanged: (value) {
        _username = value;
      },
    );
  }

  ///构建密码输入框
  Widget _buildPassword() {
    return Container(
      padding: EdgeInsets.only(top: 30),
      child: TextField(
        decoration: InputDecoration(
          errorText: _passwordErrMsg,
          labelText: "Password",
          border: OutlineInputBorder(borderSide: BorderSide()),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(Icons.lock),
          contentPadding: EdgeInsets.all(8),
        ),
        controller: _passwordController,
        onChanged: (value) {
          _password = value;
        },
        obscureText: true,
      ),
    );
  }

  ///构建历史账号ListView
  Widget _buildListView() {
    if (_expand) {
      List<Widget> children = _buildItems();
      if (children.length > 0) {
        RenderBox renderObject = _globalKey.currentContext.findRenderObject();
        final position = renderObject.localToGlobal(Offset.zero);
        double screenW = MediaQuery.of(context).size.width;
        double currentW = renderObject.paintBounds.size.width;
        double currentH = renderObject.paintBounds.size.height;
        double margin = (screenW - currentW) / 2;
        double offsetY = position.dy;
        double itemHeight = 30.0;
        double dividerHeight = 2;
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Colors.blue, width: 2),
          ),
          child: ListView(
            itemExtent: itemHeight,
            padding: EdgeInsets.all(0),
            children: children,
          ),
          width: currentW,
          height: (children.length * itemHeight +
              (children.length - 1) * dividerHeight),
          margin: EdgeInsets.fromLTRB(margin, offsetY + currentH, margin, 0),
        );
      }
    }
    return null;
  }

  ///构建历史记录items
  List<Widget> _buildItems() {
    List<Widget> list = new List();
    for (int i = 0; i < _userCounter.length; i++) {
      if (_userCounter.index(i).lastLoginAccount != _username) {
        //增加账号记录
        list.add(_buildItem(_userCounter.index(i)));
        //增加分割线
        list.add(Divider(
          color: Colors.grey,
          height: 2,
        ));
      }
    }
    if (list.length > 0) {
      list.removeLast(); //删掉最后一个分割线
    }
    return list;
  }

  ///构建单个历史记录item
  Widget _buildItem(User user) {
    return GestureDetector(
      child: Container(
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(user.lastLoginAccount),
              ),
            ),
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(right: 5),
                child: Icon(
                  Icons.highlight_off,
                  color: Colors.grey,
                ),
              ),
              onTap: () {
                setState(() {
                  _userCounter.remove(user);
                  SharedPreferenceUtil.delUser(user);
                  //处理最后一个数据，假如最后一个被删掉，将Expand置为false
                  if (!(_userCounter.length > 1 )) {
                    //如果个数大于1个或者唯一一个账号跟当前账号不一样才弹出历史账号
                    _expand = false;
                  }
                });
              },
            ),
          ],
        ),
      ),
      onTap: () {
        setState(() {
          _username = user.lastLoginAccount;
          _password = user.password;
          _accountController.text = _username;
          _passwordController.text = _password;
          _expand = false;
        });
      },
    );
  }

  ///构建登录和注册按钮
  Widget _buildButton() {
    return Container(
      child: Flex(
        mainAxisAlignment: MainAxisAlignment.center,
        direction: Axis.horizontal,
        children: <Widget>[
          FlatButton(
            onPressed: () async {
              //判断账号类型
              String accountType() {
                if (_isTel)
                  return "phone";
                else if (_isMail)
                  return "mail";
                else
                  return null;
              }

              res1 = await dioLogin(
                  dio, _username, _password, accountType(), _remember);

              setState(() {
                _isSent = true;
              });

              ///登录成功
              if (res1.statusCode == 200) {
                try {
                  List<Cookie> cookies = (await Api.cookieJar).loadForRequest(
                      Uri.parse(dio.options.baseUrl + "/v1/api/user/login"));
                  print("Load cookies successly");

                  setState(() {
                    _isSent = false;
                  });
                  Map<String, dynamic> u = json.decode(res1.data);
                  user = User.fromJson(u);
                  user.account = _username;

                  dioGetAllCards(dio, user.userId).then((res2) async {
                    if (res2.statusCode == 200) {
                      List<dynamic> js = res2.data;
                      List<CardInfo> list = CardCounter.fromJson(js).cardList;
                      Provider.of<CardCounter>(context).cardList = list;
                      print("get cards succeed");
                    } else {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: Text("Alert"),
                                content: Text("Fail to read"),
                              )
                      );
                    }
                  });
                  if (_remember == true) {
                    _userCounter.addUser(user);
                    SharedPreferenceUtil.saveUser(user);
                    SharedPreferenceUtil.addNoRepeat(
                        _userCounter.getList(), user);
                  }
                  dioGetEnterprise(dio).then((res1) async{
                    print(res1.statusCode);
                    print(res1.data);
                    if(res1.statusCode==200){
                      List<EnterpriseInfo> list = EnterpriseCounter.fromJson(jsonDecode(res1.data)).enterpriseList;
                      Provider.of<EnterpriseCounter>(context).enterpriseList = list;
                    }
                  });

                  Navigator.of(context).pushNamed("/bottomMenu", arguments: {
                    "user": user,
                  });
                  _loginMsg = "Login Suceeded";
                  print(_loginMsg);
                } on FormatException {
                  _loginMsg = "Login Failed";
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text("Alert"),
                            content: Text(_loginMsg),
                          ));
                }
              }

              //登录失败
              else if (res1.statusCode == 400) {
                _loginMsg = "Network connection failed, "
                    "check your network";
                print(res1.statusCode);
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text("Alert"),
                          content: Text(_loginMsg),
                        ));
                setState(() {
                  _isSent = false;
                });
              } else if (res1.statusCode == 406) {
                _loginMsg = "Account does not exist or Password error";
                print(res1.statusCode);
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text("Alert"),
                          content: Text(_loginMsg),
                        ));
                setState(() {
                  _isSent = false;
                });
              } else {
                _loginMsg = "Server error";
                print(res1.statusCode);
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text("Alert"),
                          content: Text(_loginMsg),
                        ));
                setState(() {
                  _isSent = false;
                });
              }
            },
            child: _isSent ? CircularProgressIndicator() : Text("Sign in"),
            color: Colors.blueGrey,
            textColor: Colors.white,
            highlightColor: Colors.blue,
          ),
          MaterialButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.of(context).pushNamed("/registerPage");
            },
            child: Text("Sign Up"),
          ),
        ],
      ),
    );
  }

  ///获取历史用户
  void _gainUsers() async {
    _userCounter.clear();
    List<User> _userList = await SharedPreferenceUtil.getUsers();
    for (int i = 0; i < _userList.length; i++){
      _userCounter.addUser(_userList[i]);
    }
    //默认加载第一个账号
    if (_userCounter.length > 0) {
      _username = _userCounter.index(0).lastLoginAccount;
      _password = _userCounter.index(0).password;
      setState(() {
        _accountController.text = _username;
        _passwordController.text = _password;
      });
    }
  }

  ///初始化输入栏控制
  void _initController() {
    //账户输入栏控制
    _accountController = TextEditingController.fromValue(
      TextEditingValue(
        text: _username,
        selection: TextSelection.fromPosition(
          TextPosition(
            affinity: TextAffinity.downstream,
            offset: _username == null ? 0 : _username.length,
          ),
        ),
      ),
    );
    _accountController.addListener(() {
      RegExp exp1 = RegExp(
          r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
      _isTel = exp1.hasMatch(_accountController.text); //校验手机号
      RegExp exp2 =
          RegExp("^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$");
      _isMail = exp2.hasMatch(_accountController.text); //校验邮箱

      if (_accountController.text.isEmpty) {
        setState(() {
          _accountCorrect = false;
          _accountErrMsg = "Can not be empty";
        });
      } else if (_isMail || _isTel) {
        setState(() {
          _accountCorrect = true;
          _accountErrMsg = null;
        });
      } else {
        setState(() {
          _accountCorrect = false;
          _accountErrMsg = "Can only input your phone number or mailbox";
        });
      }
    });

    //密码输入栏控制
    _passwordController = TextEditingController.fromValue(
      TextEditingValue(
        text: _username,
        selection: TextSelection.fromPosition(
          TextPosition(
            affinity: TextAffinity.downstream,
            offset: _username == null ? 0 : _username.length,
          ),
        ),
      ),
    );
    _passwordController.addListener(() {
      if (_passwordController.text.contains(RegExp(r"\W"))) {
        setState(() {
          _passwordCorrect = false;
          _passwordErrMsg = "Can only input 0-9, a-z and A-Z";
        });
      } else if (_passwordController.text.isEmpty) {
        setState(() {
          _passwordCorrect = false;
          _passwordErrMsg = "Password can not be empty";
        });
      } else if (_passwordController.text.length <= 6) {
        setState(() {
          _passwordCorrect = false;
          _passwordErrMsg = "Password is too short";
        });
      } else {
        setState(() {
          _passwordCorrect = true;
          _passwordErrMsg = null;
        });
      }
    });
  }
}
