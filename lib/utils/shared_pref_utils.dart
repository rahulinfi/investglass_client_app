import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

const TOKEN = "token";

class SharedPrefUtils {
  final SharedPreferences prefs;
  static late SharedPrefUtils instance;

  SharedPrefUtils._(this.prefs);

  static Future<void> createInstance() async {
    instance = SharedPrefUtils._(await SharedPreferences.getInstance());
  }

  void putBool(String key, bool value) {
    prefs.setBool(key, value);
  }

  bool? getBool(String key, {bool? defaultValue = false}) {
    if (prefs.containsKey(key)) {
      return prefs.getBool(key) ?? defaultValue;
    }
    return defaultValue;
  }

  bool? getBoolWithoutDefaultValue(String key) {
    if (prefs.containsKey(key)) {
      return prefs.getBool(key);
    }
    return null;
  }

  void putDouble(String key, double value) {
    prefs.setDouble(key, value);
  }

  double getDouble(String key, {double defaultValue = 0.0}) {
    if (prefs.containsKey(key)) {
      return prefs.getDouble(key) ?? defaultValue;
    }
    return defaultValue;
  }

  void putString(String key, String value) {
    prefs.setString(key, value);
  }

  String getString(String key, {String defaultValue = ""}) {
    if (prefs.containsKey(key)) {
      return prefs.getString(key) ?? defaultValue;
    }
    return defaultValue;
  }

  void putInt(String key, int value) {
    prefs.setInt(key, value);
  }

  int getInt(String key, {int defaultValue = 0}) {
    if (prefs.containsKey(key)) {
      return prefs.getInt(key) ?? defaultValue;
    }
    return defaultValue;
  }

  /*static List<LocalUserDetails> getLocalUserData() {
    List<LocalUserDetails> data = [];
    final localData = SharedPrefUtils.instance.getString(USER_DATA_STRING);
    if (localData.isNotEmpty) {
      final decodedData = json.decode(localData);
      data = List<LocalUserDetails>.from(
        decodedData.map((x) => LocalUserDetails.fromJson(x)),
      );
    }
    return data;
  }

  static void setLocalUserData(List<LocalUserDetails> userDetails, {bool doSubscribe = true}) async {
    SharedPrefUtils.instance.putString(
      USER_DATA_STRING,
      jsonEncode(
        userDetails.map((e) => e.toJson()).toList(),
      ),
    );

    if (doSubscribe) {
      List<LocalUserDetails> userDetails2 =
          userDetails.where((element) => element.userId == SharedPrefUtils.instance.getString(USER_ID_STRING)).toList();
      if (userDetails2.isNotEmpty) {
        LocalUserDetails details = userDetails2.first;
        Constants.subscribeTopic(Constants.orderTopic, details.isOrderNotificationEnabled!);
        Constants.subscribeTopic(Constants.newsTopic, details.isNewsNotificationEnabled!);
        Constants.subscribeTopic(Constants.marketTopic, details.isMarketNotificationEnabled!);
      }
    }
  }*/

  /*Future<bool> logout() async {
    await prefs.remove(USER_ID_STRING);
    await prefs.remove(USER_NAME_STRING);
    await prefs.remove(USER_REGISTRATION_TOKEN_STRING);
    await prefs.remove(IS_LOGGED_IN_BOOL);
    await prefs.remove(USER_TOKEN_STRING);
    await prefs.remove(OPTION_CHAIN_COUNT_INT);
    return true;
  }*/
}
