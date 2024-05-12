import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weatherAppV2proj/utils/get_location_string.dart';

Future<String> fetchPlaceByCoords(String latitude, String longitude) async {
  final response = await http.get(
    Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$latitude&lon=$longitude&accept-language=en'),
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON.
    Map<String, dynamic> locationData = jsonDecode(response.body);
    return getLocationString(locationData);
  } else {
    // If the server returns an unsuccessful response code, throw an exception.
    throw Exception('Failed to load location');
  }
}
