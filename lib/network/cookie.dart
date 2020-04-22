import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';

class Api {
  //改为使用 PersistCookieJar，在文档中有介绍，PersistCookieJar将cookie保留在文件中，因此，如果应用程序退出，则cookie始终存在，除非显式调用delete
  static PersistCookieJar _cookieJar;
  static Future<PersistCookieJar> get cookieJar async {
    // print(_cookieJar);
    if (_cookieJar == null) {
      // API `getTemporaryDirectory` is from "path_provider" package.
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      CookieJar cj=new PersistCookieJar(dir:tempPath);
      print('获取的文件系统目录 appDocPath： ' + tempPath);
      _cookieJar = new PersistCookieJar(dir: tempPath);
    }
    return _cookieJar;
  }
}