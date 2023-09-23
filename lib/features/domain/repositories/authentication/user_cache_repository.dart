import 'package:dartz/dartz.dart';
import '../../../data/models/user_model.dart';
import '../../../../shared/exceptions/http_exception.dart';

abstract class UserRepository {
  Future<Either<AppException, User>> fetchUser();
  Future<bool> saveUser({required User user});
  Future<bool> deleteUser();
  Future<bool> hasUser();
}
