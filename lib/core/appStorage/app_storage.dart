import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user_model.dart';

abstract class AppStorage {
  static final GetStorage _box = GetStorage();

  static Future<void> init() async => await GetStorage.init();

  static UserModel? get getUserInfo {
    if (_box.hasData('user')) return UserModel.fromJson(_box.read('user'));
  }

  static bool get isLogged => getUserInfo != null;

  static Future<void> cacheUserInfo(UserModel userModel) =>
      _box.write('user', userModel.toJson());

  static int get getUserId => getUserInfo!.result!.userId!;

  static UserModel get getUserData => getUserInfo!;

  static Future<void> signOut() async {
    await _box.erase();
  }
}
