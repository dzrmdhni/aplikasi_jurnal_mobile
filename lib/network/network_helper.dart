import 'dart:convert';

import 'package:aplikasi_journal_2/network/network_enums.dart';
import 'package:aplikasi_journal_2/network/network_typedef.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  const NetworkHelper._();

  static String concatUrlQP(String url, Map<String, String>? queryParamaters) {
    if (url.isEmpty) return url;
    if (queryParamaters == null || queryParamaters.isEmpty) {
      return url;
    }
    final StringBuffer stringBuffer = StringBuffer("$url?");
    queryParamaters.forEach((key, value) {
      if (value.trim() == '') return;
      if (value.contains(' ')) {
       value = value.replaceAll(RegExp(' '), '+');
        } return
      stringBuffer.write('$key=$value&');
    });
    final result = stringBuffer.toString();
      print(result);
    return result.substring(0, result.length - 1);
  }

  static bool _isValidResponse(json) {
    return json != null && 
    json['status'] != null && 
    json['status'] == 'Success' &&
    json['organic_results'] !=null;
  }

  static R filterResponse<R>({
    required NetworkCallBack callBack,
    required http.Response? response,
    required NetworkOnFailureCallBackWithMessage onFailureCallBackWithMessage,
    CallBackParameterName parameterName = CallBackParameterName.all
  }){
    try {
      if(response == null || response.body.isEmpty){
        return onFailureCallBackWithMessage(NetworkResponseErrorType.responseEmpty, 'empty response');
      }

      var json = jsonDecode(response.body);

      if(response.statusCode == 200){
        if(_isValidResponse(json)){
          return callBack(parameterName.getJson(json));
        }
      }else if(response.statusCode == 1708){
        return onFailureCallBackWithMessage(
          NetworkResponseErrorType.socket, 'Socket Error');
      }
      return onFailureCallBackWithMessage(
        NetworkResponseErrorType.didNotSucceed, 'Unknown Error'
      );
    }catch (e){
      return onFailureCallBackWithMessage(NetworkResponseErrorType.exception, 'Exception $e');
    }
  }
}