import 'package:shared_preferences/shared_preferences.dart';

import 'Keys.dart';

class AppPrefs {
  static AppPrefs _gcPrefrence = null;
  static SharedPreferences _prefrence;

  AppPrefs._internal();

  static AppPrefs getInstance() {
    if (_gcPrefrence == null || _prefrence == null) {
      _init();
      _gcPrefrence = AppPrefs._internal();
    }
    return _gcPrefrence;
  }

  static getInstanceFuture(void inner(bool initialised)) async {
    if (_gcPrefrence == null || _prefrence == null) {
      _prefrence = await SharedPreferences.getInstance();
      _gcPrefrence = AppPrefs._internal();
      inner(true);
    }
  }

  static Future _init() async {
    _prefrence = await SharedPreferences.getInstance();
  }

  bool checkLogin() {
    return _prefrence.getBool(Keys.IS_LOGIN) == null
        ? false
        : _prefrence.getBool(Keys.IS_LOGIN);
  }

  setLogin() {
    _prefrence.setBool(Keys.IS_LOGIN, true);
  }

  setLogout(bool isClear) {
    if(isClear)
      {
        int LangID=getIntData(Keys.LANGUAGE_ID);
        String fcm=getStringData(Keys.FCM_TOCKEN);
        _prefrence.clear();
        _prefrence.setBool(Keys.IS_LOGIN, false);
        _prefrence.setBool(Keys.HOME_BOTTOM_NAVIGATOR_INFO_GRAPHICS, true);
        _prefrence.setInt(Keys.LANGUAGE_ID, LangID);
        _prefrence.setString(Keys.FCM_TOCKEN, fcm);

      }
    else
      {
        _prefrence.setBool(Keys.IS_LOGIN, false);
      }
  }

  setStringData(String key, String stringData) {
    _prefrence.setString(key, stringData);
  }

  getStringData(String key) {
    return _prefrence.getString(key) == null ? "" : _prefrence.getString(key);
  }

  setIntData(String key, int value) {
    _prefrence.setInt(key, value);
  }

  getIntData(String key) {
    return _prefrence.getInt(key) == null ? 0 : _prefrence.getInt(key);
  }

  setBoolData(String key, bool value) {
    _prefrence.setBool(key, value);
  }

  getBoolData(String key) {
    return _prefrence.getBool(key) == null ? false : _prefrence.getBool(key);
  }

  setDoubleData(String key, double value) {
    _prefrence.setDouble(key, value);
  }

  getDoubleData(String key) {
    return _prefrence.getDouble(key) == null ? 0.0 : _prefrence.getDouble(key);
  }
}
