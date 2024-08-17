
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:weather_news_app/model/service/api_service/base_service.dart';
import 'package:weather_news_app/res/app_exceptions.dart';

class NewsService extends BaseService {
  dynamic responseJson;
  Future fetchNews(String category) async {
    try {
      final response = await http.get(Uri.parse('$newsapiUrl?category=$category&apiKey=$newsApiKey&country=us'));
      responseJson = parseResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      throw FetchDataException('An unexpected error occurred: $e');
    }
    return responseJson;
  }
}
