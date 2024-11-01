import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static FlutterSecureStorage get storage => const FlutterSecureStorage(
        aOptions: AndroidOptions(
            keyCipherAlgorithm:
                KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
            storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding),
      );
  static Future<dynamic> read(String key) async {
    var value = await storage.read(key: key);

    return value != null ? json.decode(value) : null;
  }

  static Future<void> save(String key, value) async {
    const storage = FlutterSecureStorage();

    return storage.write(key: key, value: json.encode(value));
  }

  static Future<void> remove(String key) async {
    const storage = FlutterSecureStorage();

    return storage.delete(key: key);
  }

  static Future<void> deleteAll() async {
    const storage = FlutterSecureStorage();

    return storage.deleteAll();
  }
}
