import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'state/auth_notifier.dart';
import 'state/auth_state.dart';
import '../../../domain/repositories/authentication/auth_repository.dart';
import '../../../domain/repositories/authentication/user_cache_repository.dart';
import '../../../providers/authentication/login_provider.dart';
import '../../../providers/authentication/user_cache_provider.dart';

final authStateNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) {
    final AuthenticationRepository authenticationRepository =
        ref.watch(authRepositoryProvider);
    final UserRepository userRepository =
        ref.watch(userLocalRepositoryProvider);
    return AuthNotifier(
      authRepository: authenticationRepository,
      userRepository: userRepository,
    );
  },
);
