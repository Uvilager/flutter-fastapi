import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_local_repository.g.dart';

class AuthLocalRepository {
  final SharedPreferences sharedPrefs;

  AuthLocalRepository(this.sharedPrefs);

  Future<void> setToken() async {
    sharedPrefs.setString('token', 'token');
    //etc...
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
