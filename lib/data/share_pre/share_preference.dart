import 'package:shared_preferences/shared_preferences.dart';

class SPref {
  SPref._internal();

  static final SPref _instance = SPref._internal();

  static SPref get instance {
    return _instance;
  }

  Future set(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
  }

  dynamic get(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.get(key);
  }
}
