import 'package:get/get.dart';
import 'package:weather/src/model/weather.dart';

class WeatherRepo{

  final String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<Weather> getWeatherInfo({
    required double latitude,
    required double longitude,
  }) async{
    final response = await GetHttpClient(
      baseUrl: _baseUrl
    ).get(
      '/weather',
      query: {
        'lat': '$latitude',
        'lon': '$longitude',
        'appid': '187ec5c99d58f5915071c36ace531102',
        'units': 'metric',
      }
    );
    return Weather.fromJson(response.body);
  }

}