import 'package:todolistapp/features/data/repositories/atuhentication_repository_impl.dart';
import 'package:todolistapp/features/domain/repositories/authentication/auth_repository.dart';
import 'package:todolistapp/shared/data/remote/remote.dart';
import 'package:todolistapp/shared/domain/providers/dio_network_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolistapp/features/data/datasources/authentication/auth_remote_data_source.dart';

final authdataSourceProvider =
    Provider.family<LoginUserDataSource, NetworkService>(
  (_, networkService) => LoginUserRemoteDataSource(networkService),
);

final authRepositoryProvider = Provider<AuthenticationRepository>(
  (ref) {
    final NetworkService networkService = ref.watch(netwokServiceProvider);
    final LoginUserDataSource dataSource =
        ref.watch(authdataSourceProvider(networkService));
    return AuthenticationRepositoryImpl(dataSource);
  },
);
