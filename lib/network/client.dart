import 'package:dio/dio.dart';

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
  return dio;
}

Future<Response<T>> dioGet<T>(String url, Dio dio) async {
  Response res = Response();
  try {
    res = await dio.get(url);
    return res;
  } on DioError catch(e) {
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