



import 'package:dartz/dartz.dart';
import 'package:todolistapp/features/data/datasources/authentication/auth_remote_data_source.dart';
import 'package:todolistapp/features/data/models/user_model.dart';
import 'package:todolistapp/features/domain/repositories/authentication/auth_repository.dart';
import 'package:todolistapp/shared/exceptions/http_exception.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final LoginUserDataSource dataSource;

  AuthenticationRepositoryImpl(this.dataSource);

  @override
  Future<Either<AppException, User>> loginUser({required User user}) {
    return dataSource.loginUser(user: user);
  }
}
