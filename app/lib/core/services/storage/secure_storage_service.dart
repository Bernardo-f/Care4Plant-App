import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage();

  Future<String?> getToken() async => await _storage.read(key: 'token');

  Future<void> saveToken(String token) async => await _storage.write(key: 'token', value: token);

  Future<void> deleteToken() async => await _storage.delete(key: 'token');
}
