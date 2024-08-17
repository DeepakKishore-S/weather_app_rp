import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:weather_news_app/model/service/api_service/base_service.dart';
import 'package:weather_news_app/res/app_exceptions.dart';

class WeatherService extends BaseService {
  dynamic responseJson;
  Future fetchWeather({
    required String lat, 
    required String lon, 
    required String units
  }) async {
    try {
      final response = await http.get(Uri.parse(
          '$weatherApiUrl/forecast?lat=$lat&lon=$lon&appid=$weatherApiKey&units=$units'));
      responseJson = parseResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      throw FetchDataException('An unexpected error occurred: $e');
    }
    return responseJson;
  }
}
