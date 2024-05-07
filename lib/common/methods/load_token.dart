import 'package:shared_preferences/shared_preferences.dart';

Future<String> loadToken() async {
  String token = '';
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  token = _prefs.getString('token') ?? '';

  return token;
}
