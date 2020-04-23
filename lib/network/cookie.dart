import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio/dio.dart';
class Api {
  // 改为使用 PersistCookieJar，在文档中有介绍，PersistCookieJar将cookie保留在文件中
  // 因此，如果应用程序退出，则cookie始终存在，除非显式调用delete
  static PersistCookieJar _cookieJar;
  static Future<PersistCookieJar> get cookieJar async {
    // print(_cookieJar);
    if (_cookieJar == null) {
      // get the path to the document directory.
      String tempPath = (await getApplicationDocumentsDirectory()).path;
      print('获取的文件系统目录 appDocPath： ' + tempPath);
      _cookieJar = new PersistCookieJar(dir: tempPath+"/.cookies/");
    }
    return _cookieJar;
  }
}