import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_local_repository.g.dart';

class AuthLocalRepository {
  final SharedPreferences sharedPrefs;

  AuthLocalRepository(this.sharedPrefs);

  Future<void> setToken({required String? token}) async {
    if (token == null) return;
    await sharedPrefs.setString('x-auth-token', token);
  }

  Future<String?> getToken() async {
    return sharedPrefs.getString('x-auth-token');
  }
}

@riverpod
AuthLocalRepository authLocalRepository(AuthLocalRepositoryRef ref) {
  final sharedPrefs = ref.read(initSharedPrefsProvider).requireValue;
  return AuthLocalRepository(sharedPrefs);
}

@Riverpod(keepAlive: true)
Future<SharedPreferences> initSharedPrefs(InitSharedPrefsRef ref) async {
  print('initialiezd shared prefs');
  return await SharedPreferences.getInstance();
}
