import 'dart:collection';
import 'dart:io';

//import 'package:customer/utils/constants.dart';
import 'package:astro/utils/constants.dart';
import 'package:dio/dio.dart';

import 'package:astro/utils/my_extensions.dart';
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';


class BaseRepo {
  static final BaseRepo _baseRepo = BaseRepo._internal();
    final key = 'AIzaSyAvFh2R7W_4hVBK_UAo5B64iriZLsyaqRo';

  Dio? _dio;

  factory BaseRepo() {
    return _baseRepo;
  }
  int? status;

  BaseRepo._internal();
  dynamic hitApi(String api,
      {dynamic params, String? accessToken, Options? options
        , bool? isDelete,int? id}) async {
    if (_dio == null) {
      _dio = Dio();

      _dio!
        ..options.baseUrl = Constants.baseUrl
        ..options.connectTimeout = Duration.millisecondsPerMinute
        ..options.receiveTimeout = Duration.millisecondsPerMinute
      ..options.followRedirects= false
      ..options.validateStatus=(status) { return status! < 500; };
    }
    _dio!.interceptors.clear();
    _dio!.interceptors.add(LogInterceptor(
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
        requestBody: true));

    if (accessToken != null ) {
      print(accessToken);
       _dio!.interceptors.add(
          InterceptorsWrapper(
              onRequest: (RequestOptions options,handler) async {
                if (accessToken != null && accessToken != '')
                  options.headers['content-Type'] = 'application/x-www-form-urlencoded';
                  options.headers['x-access-token'] = accessToken;
                return handler.next(options);
              },));
          }

          try {
      if (params != null) {
      final response = await _dio!.post(api, data: params, options: options/*new Options(followRedirects: false,
          validateStatus: (status) { return status! < 500; })*/);
      return response.data;
      } else if (isDelete != null && isDelete == true) {
      // Delete Api
      final response = await _dio!.delete(api);
      return response.data;
      } else {
      // Get Api
      final response = await _dio!.get(api);
      return response.data;
      }
      } /*on SocketException {
      throw Exception('No Internet connection');
      } */on DioError catch (e) {
      var msg = "";
      bool isUserExist = false;
      int status_code = 0;
      switch (e.type) {
      case DioErrorType.cancel:
      msg = 'Request Cancelled';
      status_code = 0;
      break;
      case DioErrorType.connectTimeout:
      msg = 'Connection Timeout';
      status_code = 0;
      break;
      case DioErrorType.connectTimeout:
      msg = 'Connection Timeout';
      status_code = 0;
      break;
      case DioErrorType.sendTimeout:
      msg = 'Connection Timeout';
      status_code = 0;
      break;
      case DioErrorType.other:
      msg = 'No Internet Connection';
      status_code = 0;
      break;
      case DioErrorType.response:
     // int? status;
      switch (e.response!.statusCode) {
      case 202:
      msg = 'non authoritive request';
      status_code = 202;
      break;
      case 203:
        msg = 'non authoritive request';
        status_code = 203;
        break;
      case 302:
      // Bearer Token Missing
      msg = 'Invalid Request';
      status_code = 302;
      break;
      case 400:
      // Bad Request
      msg = e.response!.data['message'];
      print("400 Bad Request => ${(e.response!.data as Map<String, dynamic>).containsKey("meta") ? e.response!.data["meta"]["is_user_exist"] : false}");
      isUserExist = (e.response!.data as Map<String, dynamic>).containsKey("meta") ? e.response!.data["meta"]["is_user_exist"] : false;
      status_code = 400;
      break;
      case 401:
      // Un Authorized
      'Your Session has been Expired, Please Login Again.'.showToast;
      //_logoutUser();
      msg = e.response!.data['message'];
      status_code = 401;
      break;
      case 403:
      // Forbidden
      msg = 'Forbidden Error';
      status_code = 403;
      break;
      case 404:
      // Not Found
      msg = 'Api Not Found';
      status_code = 404;
      break;
      case 500:
      // Internal Server Error
      msg = 'Server Error';
      status_code = 500;
      break;
      case 503:
      // Service Unavailable
      msg = 'Service Unavailable';
      status_code = 503;
      break;
      default:
      msg = 'Something went wrong';
      status_code = 600;
      break;
      }
      break;
      default:
      msg = 'Something went wrong';
      status_code = 601;
      break;
      }

      throw Exception(msg);
      } catch (e) {
        throw Exception('${e.toString()}');
      }
    }
  dynamic getastro() async {
    try {
      var data = await hitApi(Constants.getastro,);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  dynamic getastrobylocation(String location) async {
    try {
      var data = await hitApi(Constants.getlocationastro+location);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic getpachang(params) async {
    try {
      var data = await hitApi(Constants.getpanchang,
          params: params);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  
}