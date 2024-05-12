import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchLocations(String query) async {
  final response = await http.get(
    Uri.parse(
        'https://nominatim.openstreetmap.org/search?format=jsonv2&accept-language=en&q=$query&addressdetails=1'),
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON.
    return jsonDecode(response.body);
  } else {
    // If the server returns an unsuccessful response code, throw an exception.
    throw Exception('Failed to load locations');
  }
}

Future<List<dynamic>> fetchOneLocation(String query) async {
  final response = await http.get(
    Uri.parse(
        'https://nominatim.openstreetmap.org/search?format=jsonv2&accept-language=en&q=$query&limit=1&addressdetails=1'),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    // If the server returns an unsuccessful response code, throw an exception.
    throw Exception('Failed to load location');
  }
}
