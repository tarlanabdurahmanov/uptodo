import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolistapp/features/data/datasources/authentication/state/auth_state.dart';
import 'package:todolistapp/features/data/models/user_model.dart';
import 'package:todolistapp/features/domain/repositories/authentication/auth_repository.dart';
import 'package:todolistapp/features/domain/repositories/authentication/user_cache_repository.dart';
import 'package:todolistapp/shared/exceptions/http_exception.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthenticationRepository authRepository;
  final UserRepository userRepository;

  AuthNotifier({
    required this.authRepository,
    required this.userRepository,
  }) : super(const AuthState.initial());

  Future<void> loginUser(String username, String password) async {
    state = const AuthState.loading();
    final response = await authRepository.loginUser(
      user: User(username: username, password: password),
    );

    state = await response.fold(
      (failure) => AuthState.failure(failure),
      (user) async {
        final hasSavedUser = await userRepository.saveUser(user: user);
        if (hasSavedUser) {
          return const AuthState.success();
        }
        return AuthState.failure(CacheFailureException());
      },
    );
  }
}
