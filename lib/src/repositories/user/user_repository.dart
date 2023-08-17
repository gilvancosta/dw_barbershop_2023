import 'package:dw_barbershop_2023/src/core/exceptions/auth_exception.dart';
import 'package:dw_barbershop_2023/src/core/exceptions/repository_exception.dart';
import 'package:dw_barbershop_2023/src/core/fp/either.dart';
import 'package:dw_barbershop_2023/src/model/user_model.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);

  Future<Either<RepositoryException, UserModel>> me();
}
