class Images{
  Images._();

  static const String background = 'assets/bg.jpg';

  static String getWeatherImage(String icon) => 'http://openweathermap.org/img/w/$icon.png';
}