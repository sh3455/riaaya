import 'package:hive/hive.dart';

class HiveAuthService {
  static const _boxName = 'authBox';
  static const _uidKey = 'uid';

  Future<void> saveUser({required String uid}) async {
    final box = Hive.box(_boxName);
    await box.put(_uidKey, uid);
  }

  String? getUid() {
    final box = Hive.box(_boxName);
    return box.get(_uidKey);
  }

  Future<void> logout() async {
    final box = Hive.box(_boxName);
    await box.delete(_uidKey);
  }
}
