import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/src/controllers/weather_controller.dart';
import 'package:weather/src/controllers/location_controller.dart';
import 'package:weather/src/resources/colors.dart';
import 'package:weather/src/resources/images.dart';
import 'package:weather/src/screens/widgets/glass.dart';
import 'package:weather/src/utilities/extensions/date_time.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherController _controller = Get.put(WeatherController());
  LocationController _locationController = Get.find();

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(result == ConnectivityResult.wifi || result == ConnectivityResult.mobile){
        if(_locationController.location != null){
          _controller.getWeather(_locationController.location!);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          Images.background,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Obx((){
            if(_controller.weather != null) return _MainWeatherView();

            if(_controller.loading || _locationController.loading) return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );

            if(_locationController.location == null) return _NoLocationView();

            return Center(
              child: Text(
                'Please enable internet connection',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              )
            );
          })
        )
      ],
    );
  }
}

class _NoLocationView extends StatelessWidget {
  const _NoLocationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocationController locationController = Get.find();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Please allow location permission to see weather information'
          ),
          TextButton(
            onPressed: locationController.getUserLocation,
            child: Text(
              'Allow Permission'
            )
          )
        ],
      ),
    );
  }
}

class _MainWeatherView extends StatelessWidget {
  const _MainWeatherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WeatherController controller = Get.find();
    return Obx(()=> Stack(
      fit: StackFit.expand,
      children: [
        SafeArea(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  controller.weather!.area.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      letterSpacing: 1.2
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              CachedNetworkImage(
                                imageUrl: Images.getWeatherImage(controller.weather!.weather.icon),
                                errorWidget: (_,__,___) => SizedBox(),
                                placeholder: (_,__) => SizedBox(),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  '${controller.weather!.temperature.temp}',
                                  style: TextStyle(
                                      fontSize: 100,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 6
                                  ),
                                ),
                              ),
                              Text(
                                '°C',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    height: 2
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        controller.weather!.weather.description.capitalize!,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          letterSpacing: 1.2
                        ),
                      ),
                    )
                  ],
                ),

                Glass(
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    padding: EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.sunny,
                                    color: CColors.sunny_yellow,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Sunrise',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                controller.weather!.sys.sunrise.time,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.nightlight_rounded,
                                    color: CColors.night_black,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Sunset',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                controller.weather!.sys.sunset.time,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Spacer(),

                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white,
                      width: 1.5
                    )
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.weather!.temperature.tempMax.toString(),
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2
                                ),
                              ),
                              Text(
                                '°C',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  height: 1.2
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Max Temp',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.weather!.temperature.tempMin.toString(),
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2
                                ),
                              ),
                              Text(
                                '°C',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  height: 1.2
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Min Temp',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.weather!.wind.speed.toString(),
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2
                                ),
                              ),
                              Text(
                                'km',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  height: 1.2
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Wind',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        if(controller.loading) Positioned(
          top: 0,
          right: 0,
          left: 0,
          bottom: 0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            color: controller.loading ? Colors.black.withOpacity(.6) : Colors.transparent,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          )
        )
      ],
    ));
  }
}
