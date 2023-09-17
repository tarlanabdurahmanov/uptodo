import 'package:dartz/dartz.dart';
import 'package:todolistapp/features/data/models/user_model.dart';
import 'package:todolistapp/shared/exceptions/http_exception.dart';

abstract class AuthenticationRepository {
  Future<Either<AppException, User>> loginUser({required User user});
}
