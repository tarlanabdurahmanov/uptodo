import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/authentication/user_local_datasource.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/repositories/authentication/user_cache_repository.dart';
import '../../../shared/data/local/storage_service.dart';
import '../../../shared/domain/providers/sharedpreferences_storage_service_provider.dart';

final userDatasourceProvider = Provider.family<UserDataSource, StroageService>(
  (_, networkService) => UserLocalDatasource(networkService),
);

final userLocalRepositoryProvider = Provider<UserRepository>((ref) {
  final storageService = ref.watch(storageServiceProvider);

  final datasource = ref.watch(userDatasourceProvider(storageService));

  final respository = UserRepositoryImpl(datasource);

  return respository;
});
