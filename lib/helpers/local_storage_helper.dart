import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageHelper {
  LocalStorageHelper._internal();

  static final LocalStorageHelper _shared = LocalStorageHelper._internal();

  // factory LocalStorageHelper() {
  //   return _shared;
  // }

  Box<dynamic>? hiveBox;

  static initLocalStorageHelper() async {
    _shared.hiveBox = await Hive.openBox('TravelApp');
  }

  static void deleteValue(String key) {
    _shared.hiveBox?.delete(key);
  }

  static dynamic getValue(String key) {
    return _shared.hiveBox?.get(key);
  }

  static void setValue(String key, dynamic value) {
    _shared.hiveBox?.put(key, value);
  }
}
