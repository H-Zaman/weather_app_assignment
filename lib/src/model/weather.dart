class Weather {
  Weather({
    required this.weatherElements,
    required this.temperature,
    required this.visibility,
    required this.wind,
    required this.sys,
    required this.area,
  });

  List<WeatherElement> weatherElements;
  WeatherElement get weather => weatherElements.first;

  Temp temperature;
  num visibility;
  Wind wind;
  Sys sys;
  String area;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    weatherElements: List<WeatherElement>.from(json["weather"].map((x) => WeatherElement.fromJson(x))),
    temperature: Temp.fromJson(json["main"]),
    visibility: json["visibility"],
    wind: Wind.fromJson(json["wind"]),
    sys: Sys.fromJson(json["sys"]),
    area: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "weather": List<dynamic>.from(weatherElements.map((x) => x.toJson())),
    "main": temperature.toJson(),
    "visibility": visibility,
    "wind": wind.toJson(),
    "sys": sys.toJson(),
    "name": area,
  };
}

class Temp {
  Temp({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int humidity;

  factory Temp.fromJson(Map<String, dynamic> json) => Temp(
    temp: json["temp"].toDouble(),
    feelsLike: json["feels_like"].toDouble(),
    tempMin: json["temp_min"].toDouble(),
    tempMax: json["temp_max"].toDouble(),
    pressure: json["pressure"],
    humidity: json["humidity"],
  );

  Map<String, dynamic> toJson() => {
    "temp": temp,
    "feels_like": feelsLike,
    "temp_min": tempMin,
    "temp_max": tempMax,
    "pressure": pressure,
    "humidity": humidity,
  };
}

class Sys {
  Sys({
    required this.sunrise,
    required this.sunset,
  });

  DateTime sunrise;
  DateTime sunset;

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
    sunrise: DateTime.fromMillisecondsSinceEpoch(json["sunrise"] * 1000),
    sunset: DateTime.fromMillisecondsSinceEpoch(json["sunset"] * 1000),
  );

  Map<String, dynamic> toJson() => {
    "sunrise": sunrise.millisecondsSinceEpoch,
    "sunset": sunset.millisecondsSinceEpoch,
  };
}

class WeatherElement {
  WeatherElement({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  int id;
  String main;
  String description;
  String icon;

  factory WeatherElement.fromJson(Map<String, dynamic> json) => WeatherElement(
    id: json["id"],
    main: json["main"],
    description: json["description"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "main": main,
    "description": description,
    "icon": icon,
  };
}

class Wind {
  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  num speed;
  num deg;
  num gust;

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
    speed: json["speed"],
    deg: json["deg"],
    gust: json["gust"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "speed": speed,
    "deg": deg,
    "gust": gust,
  };
}