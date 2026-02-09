import 'package:hive_flutter/hive_flutter.dart';

class HiveAuthService {
  final _box = Hive.box('authBox');

  Future<void> saveUser({required String uid}) async {
    await _box.put('uid', uid);
    await _box.put('isLoggedIn', true);
  }

  bool isLoggedIn() => _box.get('isLoggedIn', defaultValue: false);

  String? getUid() => _box.get('uid');

  Future<void> logout() async => await _box.clear();
}
