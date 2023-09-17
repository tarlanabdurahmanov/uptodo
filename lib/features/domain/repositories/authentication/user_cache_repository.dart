import 'package:dartz/dartz.dart';
import 'package:todolistapp/features/data/models/user_model.dart';
import 'package:todolistapp/shared/exceptions/http_exception.dart';

abstract class UserRepository {
  Future<Either<AppException, User>> fetchUser();
  Future<bool> saveUser({required User user});
  Future<bool> deleteUser();
  Future<bool> hasUser();
}
