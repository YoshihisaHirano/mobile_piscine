import 'package:http/http.dart' as http;
import 'dart:convert';

class HourlyWeatherData {
  final String hour;
  final String temperature;
  final String weatherDescription;
  final String windSpeed;

  HourlyWeatherData({
    required this.hour,
    required this.temperature,
    required this.weatherDescription,
    required this.windSpeed,
  });
}

class DailyWeatherData {
  final String day;
  final String temperatureMax;
  final String temperatureMin;
  final String weatherDescription;

  DailyWeatherData({
    required this.day,
    required this.temperatureMax,
    required this.temperatureMin,
    required this.weatherDescription,
  });
}

final Map<String, String> weatherCodes = {
  '0': 'Clear sky',
  '1': 'Mainly clear',
  '2': 'Partly cloudy',
  '3': 'Overcast',
  '45': 'Fog',
  '48': 'Depositing rime fog',
  '51': 'Drizzle: Light',
  '53': 'Drizzle: Moderate',
  '55': 'Drizzle: Dense',
  '56': 'Freezing Drizzle: Light',
  '57': 'Freezing Drizzle: Dense',
  '61': 'Rain: Slight',
  '63': 'Rain: Moderate',
  '65': 'Rain: Heavy',
  '66': 'Freezing Rain: Light',
  '67': 'Freezing Rain: Heavy',
  '71': 'Snow fall: Slight',
  '73': 'Snow fall: Moderate',
  '75': 'Snow fall: Heavy',
  '77': 'Snow grains',
  '80': 'Rain showers: Slight',
  '81': 'Rain showers: Moderate',
  '82': 'Rain showers: Violent',
  '85': 'Snow showers slight',
  '86': 'Snow showers heavy',
  '95': 'Thunderstorm: Slight or moderate',
  '96': 'Thunderstorm with slight hail',
  '99': 'Thunderstorm with heavy hail',
};

String apiUrl = 'https://api.open-meteo.com/v1/forecast';

Future<String> fetchCurrentWeather(double latitude, double longitude) async {
  final response = await http.get(Uri.parse(
      '$apiUrl?latitude=$latitude&longitude=$longitude&current=temperature_2m,weather_code,wind_speed_10m&forecast_days=1'));

  if (response.statusCode == 200) {
    Map<String, dynamic> weatherData = json.decode(response.body);
    Map<String, dynamic> currentWeather = weatherData['current'];
    String temperature = '${currentWeather['temperature_2m']}°C';
    String weatherDescription =
        weatherCodes[currentWeather['weather_code'].toString()] ?? 'Unknown';
    String windSpeed = '${currentWeather['wind_speed_10m']} km/h';

    return 'Temperature: $temperature\nWeather: $weatherDescription\nWind speed: $windSpeed';
  } else {
    throw Exception('Failed to load Current weather data');
  }
}

Future<List<HourlyWeatherData>> fetchHourlyWeather(
    double latitude, double longitude) async {
  final response = await http.get(Uri.parse(
      '$apiUrl?latitude=$latitude&longitude=$longitude&hourly=temperature_2m,weather_code,wind_speed_10m&forecast_days=1'));

  if (response.statusCode == 200) {
    Map<String, dynamic> weatherData = json.decode(response.body);
    Map<String, dynamic> hourlyWeather = weatherData['hourly'];

    List<HourlyWeatherData> hourlyWeatherData = [];
    List<dynamic> hourlyWeatherTime = hourlyWeather['time'];
    List<dynamic> hourlyWeatherTemp = hourlyWeather['temperature_2m'];
    List<dynamic> hourlyWeatherCode = hourlyWeather['weather_code'];
    List<dynamic> hourlyWeatherWind = hourlyWeather['wind_speed_10m'];
    for (var i = 0; i < hourlyWeatherTime.length; i++) {
      hourlyWeatherData.add(HourlyWeatherData(
          hour: hourlyWeatherTime[i],
          temperature: hourlyWeatherTemp[i].toString(),
          weatherDescription:
              weatherCodes[hourlyWeatherCode[i].toString()] ?? 'Unknown',
          windSpeed: hourlyWeatherWind[i].toString()));
    }

    return hourlyWeatherData;
  } else {
    throw Exception('Failed to load Today\'s hourly weather data');
  }
}

Future<List<DailyWeatherData>> fetchDailyWeather(
    double latitude, double longitude) async {
  final response = await http.get(Uri.parse(
      '$apiUrl?latitude=$latitude&longitude=$longitude&daily=temperature_2m_max,temperature_2m_min,weather_code&forecast_days=7'));

  if (response.statusCode == 200) {
    Map<String, dynamic> weatherData = json.decode(response.body);
    Map<String, dynamic> dailyWeather = weatherData['daily'];
    List<dynamic> dailyWeatherDay = dailyWeather['time'];
    List<dynamic> dailyWeatherTempMax = dailyWeather['temperature_2m_max'];
    List<dynamic> dailyWeatherTempMin = dailyWeather['temperature_2m_min'];
    List<dynamic> dailyWeatherCode = dailyWeather['weather_code'];


    List<DailyWeatherData> dailyWeatherData = [];
    for (var i = 0; i < dailyWeatherDay.length; i++) {
      dailyWeatherData.add(DailyWeatherData(
        day: dailyWeatherDay[i],
        temperatureMax: dailyWeatherTempMax[i].toString(),
        temperatureMin: dailyWeatherTempMin[i].toString(),
        weatherDescription: weatherCodes[dailyWeatherCode[i].toString()] ?? 'Unknown',
      ));
    }

    return dailyWeatherData;
  } else {
    throw Exception('Failed to load 7 days weather data');
  }
}
