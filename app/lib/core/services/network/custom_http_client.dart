import 'dart:convert';

import 'package:care4plant/core/services/l10n/l10n_service.dart';
import 'package:care4plant/env.dart';
import 'package:http/http.dart' as http;
import 'package:care4plant/core/services/storage/secure_storage_service.dart';

class CustomHttpClient {
  final http.Client _client = http.Client();
  final SecureStorageService _storage = SecureStorageService();
  String localeName = 'es';

  void setLocale(String locale) {
    localeName = locale;
  }

  Future<http.Response> get(String url) async {
    final token = await _storage.getToken();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept-Language': localeName,
    };

    return _client.get(Uri.parse(url), headers: headers).timeout(timeOut,
        onTimeout: () => http.Response(L10nService.localizations.severError, 408));
  }

  // Si necesitas POST, puedes agregar algo así:
  Future<http.Response> post(String url, {Map<String, dynamic>? body}) async {
    final token = await _storage.getToken();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept-Language': localeName,
    };

    return _client.post(Uri.parse(url), headers: headers, body: jsonEncode(body)).timeout(timeOut,
        onTimeout: () => http.Response(L10nService.localizations.severError, 408));
  }

  //PostForm
  Future<http.Response> postForm(String url, {Map<String, dynamic>? body}) async {
    final token = await _storage.getToken();
    final headers = {
      'Authorization': 'Bearer $token',
      'Accept-Language': localeName,
    };
    return _client.post(Uri.parse(url), headers: headers, body: body).timeout(timeOut,
        onTimeout: () => http.Response(L10nService.localizations.severError, 408));
  }

  //PostValue

  Future<http.Response> postValue(String url, dynamic value) async {
    final token = await _storage.getToken();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept-Language': localeName,
    };

    return _client.post(Uri.parse(url), headers: headers, body: value).timeout(timeOut,
        onTimeout: () => http.Response(L10nService.localizations.severError, 408));
  }
}
