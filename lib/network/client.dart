import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:membership_card/model/card_model.dart';
import 'package:membership_card/model/user_model.dart';

Dio initDio() {
  Dio dio = Dio(
    // This is the base options for Dio client to connect to server
    BaseOptions(
      baseUrl: "http://101.37.27.155:8080",
      connectTimeout: 3000,
      receiveTimeout: 3000,
      receiveDataWhenStatusError: false,
      sendTimeout: 3000,
    ),
  );
  // You can add dio interceptors here
  return dio;
}

Future<Response<T>> dioGetAllCards<T>(Dio dio) async {
  Response res = Response();
  try {
    res = await dio.get("/v1/api/users");
    return res;
  } on DioError catch (e) {
    if (e.response == null) {
      res.data = "Error occured before connection";
      res.statusCode = 500;
      return res;
    } else {
      res.statusCode = e.response.statusCode;
      return res;
    }
  }
}

Future<Response<T>> dioLogin<T>(Dio dio, User user) async {
  Response res = Response();
  try {
    res = await dio.put<String>(
      "/v1/api/user/login",
      data: jsonEncode(user.toJson()),
    );
    print("${res.statusCode}");

  } on DioError catch (e) {
    if (e.response == null) {
      res.statusCode = 500;
      res.data = "Error from the server, meet 500 error";
      return res;
    } else {
      return e.response;
    }
  }
  return res;
}

Future<Response<T>> dioDelete<T>(CardInfo cardInfo, Dio dio) async {
  var res = Response();
  try {
    res = await dio.post(
      "/v1/api/users/card/id/delete",
      data: jsonEncode(cardInfo.idToJson()),
      queryParameters: cardInfo.idToJson(),
    );
    return res;
  }on DioError catch(e) {
    if (e.response == null) {
      res.statusCode = 500;
      res.data = "Error from the server, meet 500 error";
      return res;
    }else {
      res.statusCode = e.response.statusCode;
      return res;
    }
  }

}


Future<Response<T>> dioAdd<T>(Dio dio,CardInfo cardInfo)async {
  Response res=Response();

  try{
    res=await dio.post(
   " /v1/api/users/card/:id",
       data: jsonEncode(cardInfo.toJson()),
      queryParameters: cardInfo.toJson(),
    );
    print("${res.statusCode}");
  } on DioError catch(e) {
    if (e.response == null) {
      res.statusCode = 500;
      res.data = "Error from the server, meet 500 error";
      return res;
    }else {
      res.statusCode = e.response.statusCode;
      return res;
    }
  }
  return res;
}

Future<Response<T>> dioModify<T>(Dio dio,CardInfo cardInfo)async{
  Response res=Response();

  try{
    res=await dio.put(
      " /v1/api/users/card/:id/info",
      data: jsonEncode(cardInfo.toJson()),
      queryParameters: cardInfo.toJson(),
    );
    print("${res.statusCode}");
  } on DioError catch(e) {
    if (e.response == null) {
      res.statusCode = 500;
      res.data = "Error from the server, meet 500 error";
      return res;
    }else {
      res.statusCode = e.response.statusCode;
      return res;
    }
  }
  return res;
}
