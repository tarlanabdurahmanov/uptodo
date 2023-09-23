import 'package:dartz/dartz.dart';
import '../../../data/models/user_model.dart';
import '../../../../shared/exceptions/http_exception.dart';

abstract class AuthenticationRepository {
  Future<Either<AppException, User>> loginUser({required User user});
}
