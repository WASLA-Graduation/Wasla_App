import 'package:hive_flutter/hive_flutter.dart';
import 'package:wasla/core/utils/app_strings.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
    HiveService.openBox(boxName: AppStrings.socialBox);
  }

  static Future<void> openBox({required String boxName}) async {
    await Hive.openBox(boxName);
  }

  static Box getBox({required String boxName}) {
    return Hive.box(boxName);
  }

  static Future<void> put({
    required String boxName,
    required String key,
    required dynamic value,
  }) async {
    final box = getBox(boxName: boxName);
    await box.put(key, value);
  }

  static dynamic get({
    required String boxName,
    required String key,
    dynamic defaultValue,
  }) {
    final box = getBox(boxName: boxName);
    return box.get(key, defaultValue: defaultValue);
  }

  static Future<void> delete({
    required String boxName,
    required String key,
  }) async {
    final box = getBox(boxName: boxName);
    await box.delete(key);
  }

  static Future<void> putAll({
    required String boxName,
    required Map<String, dynamic> map,
  }) async {
    final box = getBox(boxName: boxName);
    await box.putAll(map);
  }

  static Future<void> deleteAll({
    required String boxName,
    required List<String> keys,
  }) async {
    final box = getBox(boxName: boxName);
    await box.deleteAll(keys);
  }

  static Future<void> clear({required String boxName}) async {
    //remove all values of this box
    final box = getBox(boxName: boxName);
    await box.clear();
  }

  static Future<void> deleteFromDisk(String boxName) async {
    await Hive.deleteBoxFromDisk(boxName);
  }
}
