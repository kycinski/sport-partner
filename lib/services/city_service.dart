import 'package:shared_preferences/shared_preferences.dart';

class CityService {
  final String _selectedCityKey = 'selected_city';

  Future<void> saveSelectedCity(String cityName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedCityKey, cityName);
  }

  Future<String?> getSelectedCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_selectedCityKey);
  }
}
