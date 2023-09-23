import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../authentication/user_cache_provider.dart';

// final userLoginCheckProvider = FutureProvider((ref) async {
//   final repo = ref.watch(userLocalRepositoryProvider);
//   return await repo.hasUser();
// });

final userProvider =
    Provider<User?>((ref) => FirebaseAuth.instance.currentUser);
