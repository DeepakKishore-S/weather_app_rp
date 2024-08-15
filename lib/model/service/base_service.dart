import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:weather_news_app/res/app_exceptions.dart';

abstract class BaseService {
  final String weatherApiKey = '3b2d7998499c78ae4038bd462eb385c3';
  final String weatherApiUrl = 'https://api.openweathermap.org/data/2.5';

  parseResponse(Response response){
    final responseBody = response.body;
    switch (response.statusCode) {
      case 200:
        return jsonDecode(responseBody);
      case 400:
        throw BadRequestException(responseBody.toString());
      case 401:
      case 403:
        throw UnauthorisedException(responseBody.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while communicating with server'
            ' with status code : ${response.statusCode}');
    }
  }
}