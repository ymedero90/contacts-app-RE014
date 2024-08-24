import 'dart:async';

import 'package:contacts_app_re014/common/infrastructura/services/local_storage_service/constants.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageService {
  late Box appBox;
  late Box contactBox;
  late Box credentialsBox;
  late Box userBox;

  Future<void> _openBox() async {
    appBox = await Hive.openBox(LocalBoxes.AppBox);
    contactBox = await Hive.openBox(LocalBoxes.ContactsBox);
    credentialsBox = await Hive.openBox(LocalBoxes.AuthBox);
    userBox = await Hive.openBox(LocalBoxes.UsersBox);
  }

  Future<LocalStorageService> init() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    await _openBox();
    return this;
  }

  Box? _getBox(String boxName) {
    switch (boxName) {
      case LocalBoxes.AppBox:
        return appBox;
      case LocalBoxes.ContactsBox:
        return contactBox;
      case LocalBoxes.UsersBox:
        return userBox;
      case LocalBoxes.AuthBox:
        return credentialsBox;

      default:
        return null;
    }
  }

  Future<void> add<T>(T item, String boxName) async {
    final box = _getBox(boxName);
    await box?.add(item);
  }

  Future<List<int>> addAll<T>(List<T> items, String boxName) async {
    final box = _getBox(boxName);
    final response = await box?.addAll(items);
    return response?.toList() ?? [];
  }

  Future<T> get<T>(String key, String boxName) async {
    final box = _getBox(boxName);
    final response = await box?.get(key);
    return response;
  }

  Future<T> getAt<T>(int index, String boxName) async {
    final box = _getBox(boxName);
    final response = await box?.getAt(index);
    return response;
  }

  Future<List<T>> getAll<T>(String boxName) async {
    final box = _getBox(boxName);
    List<T> boxList = [];
    int length = box?.length ?? 0;

    for (int i = 0; i < length; i++) {
      boxList.add(box?.getAt(i));
    }
    return boxList;
  }

  Future<void> deleteAt<T>(int index, String boxName) async {
    final box = _getBox(boxName);
    await box?.deleteAt(index);
  }

  Future<void> delete<T>(String key, String boxName) async {
    final box = _getBox(boxName);
    await box?.delete(key);
  }

  Future<void> deleteAll<T>(String boxName) async {
    final box = _getBox(boxName);
    await box?.deleteAll(box.keys);
  }

  Future<int> putAt<T>(int index, T item, String boxName) async {
    final box = _getBox(boxName);
    await box?.putAt(index, item);
    return index;
  }

  Future<void> put<T>(String key, T item, String boxName) async {
    final box = _getBox(boxName);
    await box?.put(key, item);
  }

  Future<void> putAll<T>(Map<String, dynamic> items, String boxName) async {
    final box = _getBox(boxName);
    await box?.putAll(items);
  }

  FutureOr onClose() async {
    for (var item in LocalBoxes.AllBoxes) {
      if (Hive.isBoxOpen(item)) {
        await Hive.box(item).compact();
      }
    }
    await Hive.close();
  }
}
