import 'dart:convert';

import 'package:auth/src/core/configs/constants.dart';
import 'package:hive_ce/hive.dart';

import '../../../features/settings/data/repositories/hive_box.dart';
import '../../utils/extensions/extensions.dart';

part 'auth_store.ext.dart';
part 'auth_store.g.dart';

@HiveType(typeId: HiveTypes.authStores)
class AuthStore extends HiveObject {
  @HiveField(0)
  String accessToken;
  @HiveField(1)
  String refreshToken;

  AuthStore({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthStore.fromJson(Map<String, dynamic> json) => AuthStore(
        accessToken: json[_Json.accessToken] as String,
        refreshToken: json[_Json.refreshToken] as String,
      );

  factory AuthStore.fromRawJson(String source) =>
      AuthStore.fromJson(json.decode(source));

  Map<String, dynamic> toJson() => {
        _Json.accessToken: accessToken,
        _Json.refreshToken: refreshToken,
      };

  String toRawJson() => json.encode(toJson());

  @override
  String toString() => toRawJson();

  bool get isAccessTokenValid => _isValid(accessToken);
  bool get isRefreshTokenValid => _isValid(refreshToken);

  bool _isValid(String token) {
    final parts = token.split('.');
    if (parts.length != 3) return false;

    final tokenPart = base64.normalize(parts[1]);
    final data = jsonDecode(utf8.decode(base64Decode(tokenPart)))
        as Map<String, dynamic>;

    final exp = data['exp'] is int
        ? data['exp'] as int
        : (int.tryParse(data['exp'].toString()) ?? 0);

    return exp > (DateTime.now().millisecondsSinceEpoch / 1000);
  }

}

class _Json {
  static const accessToken = 'access_token';
  static const refreshToken = 'refresh_token';
}