import 'package:client/core/model/user_model.dart';
import 'package:client/features/auth/repository/auth_local_repository.dart';
import 'package:client/features/auth/repository/auth_remote_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class AuthViewModel extends _$AuthViewModel {
  @override
  AsyncValue<UserModel>? build() {
    return null;
  }

  Future<void> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    final res = await ref.read(authRemoteRepositoryProvider).signup(
          name: name,
          email: email,
          password: password,
        );

    final val = switch (res) {
      Left(value: final l) => state = AsyncValue.error(
          l.message,
          StackTrace.current,
        ),
      Right(value: final r) => state = AsyncValue.data(r),
    };
    print(val);
  }

  Future<void> signInUser({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    final res = await ref.read(authRemoteRepositoryProvider).login(
          email: email,
          password: password,
        );

    final val = switch (res) {
      Left(value: final l) => state = AsyncValue.error(
          l.message,
          StackTrace.current,
        ),
      Right(value: final r) => _loginSuccess(r),
    };
    print('auth viewmodel: $val');
  }

  AsyncValue<UserModel>? _loginSuccess(UserModel user) {
    ref.read(authLocalRepositoryProvider).setToken(token: user.token);
    return state = AsyncValue.data(user);
  }
}
