import 'package:get/get.dart';
import 'package:weather/src/controllers/weather_controller.dart';
import 'package:weather/src/controllers/location_controller.dart';
import 'package:weather/src/repositories/weather_repository.dart';

class RootBindings extends Bindings{
  @override
  void dependencies() {
    // Repositories
    Get.put(WeatherRepo());

    // Controllers
    Get.put(WeatherController());
    Get.put(LocationController());
  }

}