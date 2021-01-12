import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io' show Platform;
import 'package:package_info/package_info.dart';

class DioClient {
  final String apiBaseUrl;

  DioClient({@required this.apiBaseUrl});

  Dio get dio => _getDio();

  Dio _getDio() {
    BaseOptions options = BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: 50000,
      receiveTimeout: 30000,
    );
    Dio dio = Dio(options);
    dio.interceptors.addAll(<Interceptor>[_loggingInterceptor()]);

    return dio;
  }

  Interceptor _loggingInterceptor() {
    return InterceptorsWrapper(onRequest: (RequestOptions options) {
      // Do something before request is sent
      debugPrint("\n"
          "Request ${options.uri} \n"
          "-- headers --\n"
          "${options.headers.toString()} \n"
          "");

      return options; //continue
      // If you want to resolve the request with some custom data，
      // you can return a `Response` object or return `dio.resolve(data)`.
      // If you want to reject the request with a error message,
      // you can return a `DioError` object or return `dio.reject(errMsg)`
    }, onResponse: (Response response) {
      // Do something with response data
      if (response.statusCode == 200) {
        debugPrint("\n"
            "Response ${response.request.uri} \n"
            "-- headers --\n"
            "${response.headers.toString()} \n"
            "-- payload --\n"
            "${jsonEncode(response.data)} \n"
            "");
      } else {
        debugPrint("Dio Response Status --> ${response.statusCode}");
      }
      return response; // continue
    }, onError: (DioError e) {
      // Do something with response error
      debugPrint("Dio Response Error --> $e");

      if (e.response.statusCode != 200) {
        _sendErrorLog(e.response);
      }
      return e; //continue
    });
  }

  void _sendErrorLog(Response response) async {
    var now = DateTime.now();
    var formattedDateAndTime = DateFormat('d MMM yyyy, HH:mm:ss').format(now);

    var platform = Platform.isAndroid ? 'Android' : 'iOS';

    var packageInfo = await PackageInfo.fromPlatform();
    var packageName = packageInfo.packageName;
    var version = packageInfo.version;

    const TELEGRAM_BOT_ID = '';
    const TELEGRAM_CHANNEL_ID =
        '';

    var customText = '\n'
        '*Oops. An issue detected* \n\n'
        'Platform: $platform \n'
        'Package Name: $packageName \n'
        'Version: $version \n\n'
        'Created at: $formattedDateAndTime \n'
        'URL Endpoint: ${response.request.uri} \n'
        'HTTP Status Code: ${response.statusCode} \n'
        'HTTP Method: ${response.request.method} \n\n'
        'Request Data: ${response.request.data} \n'
        'Response Data: ${jsonEncode(response.data)}'
        .trim();

    var apiTelegramBot = 'https://api.telegram.org/bot' +
        TELEGRAM_CHANNEL_ID +
        '/sendMessage?chat_id=' +
        TELEGRAM_BOT_ID +
        '_ID&text=' +
        customText.trim() +
        '&parse_mode=Markdown&disable_notification=true';

    await dio.get(apiTelegramBot);
  }

}