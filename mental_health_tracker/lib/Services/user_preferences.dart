import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences _preferences = SharedPreferences.getInstance() as SharedPreferences;

  static const _keyCounter = 'counter';

  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static Future setCounter(int counter) async =>
    await _preferences.setInt(_keyCounter, counter);

  static int? getCounter() => _preferences.getInt(_keyCounter);

}