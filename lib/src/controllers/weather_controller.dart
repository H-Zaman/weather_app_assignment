import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:weather/src/model/weather.dart';
import 'package:weather/src/repositories/weather_repository.dart';
import 'package:weather/src/utilities/local_storage.dart';

class WeatherController extends GetxController{

  WeatherRepo _weatherRepo = Get.find();
  LocalStorage _localStorage = LocalStorage();

  Rxn<Weather> _weatherData = Rxn();
  Weather? get weather => _weatherData.value;
  set weather (Weather? weather) => _weatherData(weather);

  RxBool _loading = RxBool(false);
  bool get loading => _loading.value;

  void getWeather(LocationData? location, [bool load = true]) async{
    final connectivity = await Connectivity().checkConnectivity();
    if(connectivity == ConnectivityResult.wifi || connectivity == ConnectivityResult.mobile) {
      if(load) _loading(true);
      weather = await _weatherRepo.getWeatherInfo(
        latitude: location!.latitude!,
        longitude: location.longitude!
      );
      _localStorage.saveData(weather!);
      _loading(false);
    }
  }

  @override
  void onInit() {
    weather = _localStorage.getData();
    super.onInit();
  }
}