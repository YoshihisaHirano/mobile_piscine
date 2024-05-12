String getLocationString(Map<String, dynamic>? locationData) {
  if (locationData == null) {
    return '';
  }
  Map<String, dynamic> address = locationData['address'] ?? '';
  String country = address['country'] ?? address['country_code'] ?? '';
  String region = address['region'] ?? address['state'] ?? address['county'] ?? '';
  String city = address['city'] ?? address['city_district'] ?? address['municipality'] ?? address['village'] ?? locationData['name'] ?? '';
  return [city, region, country].where((part) => part.isNotEmpty).join(', ');
}