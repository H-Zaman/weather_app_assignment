import 'package:get_storage/get_storage.dart';
import 'package:weather/src/model/weather.dart';

class LocalStorage{
  final GetStorage _storage = GetStorage();
  static Future<void> init() async{
    await GetStorage.init();
  }

  Future<void> saveData(Weather weather) async{
    _storage.write(_StorageKeys.weatherData, weather.toJson());
  }

  Weather? getData(){
    if(_storage.hasData(_StorageKeys.weatherData)){
      final value = _storage.read(_StorageKeys.weatherData);
      if(value != null && value != ''){
        return Weather.fromJson(value);
      }else{
        return null;
      }
    }else{
      return null;
    }
  }
}

class _StorageKeys{
  _StorageKeys._();

  static const weatherData = 'user_weather_data';
}