
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static Future<SharedPreferences> get _instance async => _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static String getString(SharedKeys key, [String? defValue]) {
    return _prefsInstance!.getString(key.name) ?? defValue ?? "";
  }

  static Future<bool> setString(SharedKeys key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key.name, value);
  }

  static Future<bool> removeData(
      SharedKeys key,
      )async
  {
    return await _prefsInstance!.remove(key.name);
  }
}


enum SharedKeys
{
  theme,
  language,
  uId,
}