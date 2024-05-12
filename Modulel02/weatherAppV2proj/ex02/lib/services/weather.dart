import 'package:http/http.dart' as http;
import 'dart:convert';

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

Future<String> fetchCurrentWeather(
    double latitude, double longitude) async {
  final response = await http.get(Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current=temperature_2m,weather_code,wind_speed_10m&forecast_days=1'));

  if (response.statusCode == 200) {
    Map<String, dynamic> weatherData = json.decode(response.body);
    String temperature =
        '${weatherData['current']['temperature_2m']}°C';
    String weatherDescription =
        weatherCodes[weatherData['current']['weather_code'].toString()] ??
            'Unknown';
    String windSpeed =
        '${weatherData['current']['wind_speed_10m']} km/h';

    return 'Temperature: $temperature\nWeather: $weatherDescription\nWind speed: $windSpeed';
  } else {
    throw Exception('Failed to load Current weather data');
  }
}
