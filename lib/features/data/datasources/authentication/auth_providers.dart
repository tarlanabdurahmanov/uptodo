import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolistapp/features/data/datasources/authentication/state/auth_notifier.dart';
import 'package:todolistapp/features/data/datasources/authentication/state/auth_state.dart';
import 'package:todolistapp/features/domain/repositories/authentication/auth_repository.dart';
import 'package:todolistapp/features/domain/repositories/authentication/user_cache_repository.dart';
import 'package:todolistapp/features/providers/authentication/login_provider.dart';
import 'package:todolistapp/features/providers/authentication/user_cache_provider.dart';

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
