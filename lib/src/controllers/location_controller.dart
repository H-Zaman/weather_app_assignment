import 'dart:developer';

import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:weather/src/controllers/weather_controller.dart';

class LocationController extends GetxController{

  WeatherController _homeController = Get.find();

  RxBool _loading = RxBool(true);
  bool get loading => _loading.value;

  Rxn<LocationData> _locationData = Rxn();
  LocationData? get location => _locationData.value;

  @override
  void onInit() {
    super.onInit();
    getUserLocation();
    _locationData.listen(_homeController.getWeather);
  }

  void getUserLocation() async{
    _loading(true);
    try{
      Location location = Location();

      bool serviceEnabled;
      PermissionStatus permissionGranted;

      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      _locationData.value = await location.getLocation();
    }catch(err){
      log(err.toString());
    }finally{
      _loading(false);
    }
  }
}