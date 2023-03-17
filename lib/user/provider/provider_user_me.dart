import 'package:delivery_codefactory/common/const/data.dart';
import 'package:delivery_codefactory/common/secure_storage/secure_storage.dart';
import 'package:delivery_codefactory/user/model/model_user.dart';
import 'package:delivery_codefactory/user/repository/repository_auth.dart';
import 'package:delivery_codefactory/user/repository/repository_user_me.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final stateNotifierProviderUserMe = StateNotifierProvider<StateNotifierUserMe, ModelUserBase?>(
  (ref) => StateNotifierUserMe(
    repositoryUserMe: ref.watch(providerRepositoryUserMe),
    repositoryAuth: ref.watch(providerRepositoryAuth),
    storage: ref.watch(providerStorage),
  ),
);

class StateNotifierUserMe extends StateNotifier<ModelUserBase?> {
  final RepositoryUserMe repositoryUserMe;
  final RepositoryAuth repositoryAuth;
  final FlutterSecureStorage storage;

  StateNotifierUserMe({
    required this.repositoryUserMe,
    required this.repositoryAuth,
    required this.storage,
  }) : super(ModelUserLoading()) {
    getUserMe();
  }

  Future<void> getUserMe() async {
    final accessToken = await storage.read(key: Token_Key_Access);
    final refreshToken = await storage.read(key: Token_Key_Refresh);

    if (accessToken == null || refreshToken == null) {
      state = null;
      return;
    }

    final resp = await repositoryUserMe.getUserMe();

    state = resp;

    return;
  }

  Future<ModelUserBase> logIn({
    required String username,
    required String password,
  }) async {
    try {
      state = ModelUserLoading();

      final resp = await repositoryAuth.logIn(username: username, password: password);

      await storage.write(key: Token_Key_Refresh, value: resp.refreshToken);
      await storage.write(key: Token_Key_Access, value: resp.accessToken);

      final modelUser = await repositoryUserMe.getUserMe();

      state = modelUser;

      return modelUser;
    } catch (e) {
      state = ModelUserError(message: '로그인에 실패 했습니다.');

      return Future.value(state);
    }
  }

  Future<void> logOut() async {
    state = null;

    await Future.wait([
      storage.delete(key: Token_Key_Access),
      storage.delete(key: Token_Key_Refresh),
    ]);
  }
}
