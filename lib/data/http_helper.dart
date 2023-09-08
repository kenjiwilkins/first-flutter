import 'package:hello_world/data/weather.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as fetch;
import 'dart:convert';

class HttpHelper {
  final String protocol = 'https';
  final String host = 'api.openweathermap.org';
  final String path = '/data/2.5/weather';
  final String apiKey = dotenv.env['OPEN_WEATHER_API_KEY'] as String;

  Future<Weather> getWeather(String location) async {
    Map<String, dynamic> parameters = {
      'q': location,
      'appId': apiKey,
    };
    Uri uri = Uri.https(host, path, parameters);
    fetch.Response result = await fetch.get(uri);

    Map<String, dynamic> data = jsonDecode(result.body);

    Weather weather = Weather.fromJson(data);

    return weather;
  }
}
