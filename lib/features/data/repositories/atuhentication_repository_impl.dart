import 'package:dartz/dartz.dart';
import '../datasources/authentication/auth_remote_data_source.dart';
import '../models/user_model.dart';
import '../../domain/repositories/authentication/auth_repository.dart';
import '../../../shared/exceptions/http_exception.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthUserDataSource dataSource;

  AuthenticationRepositoryImpl(this.dataSource);

  @override
  Future<Either<AppException, User>> loginUser({required User user}) {
    return dataSource.loginUser(user: user);
  }

  @override
  Future<Either<AppException, User>> registerUser({required User user}) {
    return dataSource.registerUser(user: user);
  }
}
