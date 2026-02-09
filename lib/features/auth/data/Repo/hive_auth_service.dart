import 'package:hive/hive.dart';

class HiveAuthService {
  static const String _boxName = 'authBox';
  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _keyUserType = 'userType';
  static const String _keyUid = 'uid';

  static Future<void> init() async {
    await Hive.openBox(_boxName);
  }

  Future<void> saveLogin({required String userType, required String uid}) async {
    final box = Hive.box(_boxName);
    await box.put(_keyIsLoggedIn, true);
    await box.put(_keyUserType, userType);
    await box.put(_keyUid, uid);
  }

  Future<void> clearLogin() async {
    final box = Hive.box(_boxName);
    await box.clear();
  }

  Map<String, dynamic> getLoginStatus() {
    final box = Hive.box(_boxName);
    return {
      'isLoggedIn': box.get(_keyIsLoggedIn, defaultValue: false),
      'userType': box.get(_keyUserType, defaultValue: null),
      'uid': box.get(_keyUid, defaultValue: null),
    };
  }

  bool get isClient {
    final status = getLoginStatus();
    return status['isLoggedIn'] == true && status['userType'] == 'client';
  }
}
