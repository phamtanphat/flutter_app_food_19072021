import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_app_food/data/constants/key.dart';
import 'package:flutter_app_food/data/share_pre/share_preference.dart';

class DioClient {
  Dio? _dio;
  static BaseOptions _options = new BaseOptions(
    baseUrl: "http://192.168.1.7:8000/",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  static final DioClient instance = DioClient._internal();

  DioClient._internal() {
    if (_dio == null){
      _dio = Dio(_options);
      _dio!.interceptors.add(LogInterceptor(requestBody: true));
      _dio!.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) async{
          var token = await SPref.instance.get(ConstantKey.TOKEN);
          if (token != null) {
            options.headers["Authorization"] = "Bearer " + token;
          }
          handler.next(options);
        },
        onResponse: (e, handler) {
          handler.next(e);
        },
        onError: (e, handler) {
          handler.next(e);
        },
      ));
    }
  }

  Dio get dio => _dio!;
}
