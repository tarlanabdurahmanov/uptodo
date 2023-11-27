import 'package:dartz/dartz.dart';
import '../../models/user_model.dart';
import '../../../../shared/data/remote/remote.dart';
import '../../../../shared/exceptions/http_exception.dart';

abstract class AuthUserDataSource {
  Future<Either<AppException, User>> loginUser({required User user});
  Future<Either<AppException, User>> registerUser({required User user});
}

class AuthRemoteDataSource implements AuthUserDataSource {
  final NetworkService networkService;

  AuthRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, User>> loginUser({required User user}) async {
    try {
      final eitherType = await networkService.post(
        '/auth/login',
        data: user.toJson(),
      );

      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final user = User.fromJson(response.data);
          // update the token for requests
          networkService.updateHeader(
            {'Authorization': user.token},
          );

          return Right(user);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occured',
          statusCode: 1,
          identifier: '${e.toString()}\nLoginUserRemoteDataSource.loginUser',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, User>> registerUser({required User user}) async {
    try {
      final eitherType = await networkService.post(
        '/auth/register',
        data: user.toJson(),
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final user = User.fromJson(response.data);
          networkService.updateHeader(
            {'Authorization': user.token},
          );
          return Right(user);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occured',
          statusCode: 1,
          identifier: '${e.toString()}\nLoginUserRemoteDataSource.loginUser',
        ),
      );
    }
  }
}
