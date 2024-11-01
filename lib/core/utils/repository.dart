import 'package:teste_web/core/utils/secure_storage.dart';

class Repository {
  static Future read(String key) async {
    return SecureStorage.read(key);
  }

  static save(String key, value) async {
    return SecureStorage.save(key, value);
  }

  static remove(String key) async {
    return SecureStorage.remove(key);
  }
}
