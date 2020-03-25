import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:membership_card/model/user_model.dart';

const SERVER_URL = "http://106.15.198.136";
const PORT       = "8080";

Dio initDio() {
  Dio dio = Dio(
    // This is the base options for Dio client to connect to server
    BaseOptions(
      baseUrl: "http://106.15.198.136:8080",
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

Future<Response<T>> dioDelete<T>(String url, Dio dio) async {
  var res = Response();
  res = await dio.delete(
    "/api/user/card",
    queryParameters: {
      "id": 200,
    },
  );
  return res;
}
