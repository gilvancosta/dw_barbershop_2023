import 'package:dw_barbershop_2023/src/core/exceptions/auth_exception.dart';
import 'package:dw_barbershop_2023/src/core/exceptions/repository_exception.dart';
import 'package:dw_barbershop_2023/src/core/fp/either.dart';
import 'package:dw_barbershop_2023/src/core/fp/nil.dart';
import 'package:dw_barbershop_2023/src/model/user_model.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);

  Future<Either<RepositoryException, UserModel>> me();

  Future<Either<RepositoryException, Nil>> registerAdmin(
    ({
      String name,
      String email,
      String password,
    }) userData,
  );



  Future<Either<RepositoryException, List<UserModel>>> getEmployees(int barbershopId);

  Future<Either<RepositoryException, Nil>> registerAdmAsEmployee(
      ({
        List<String> workdays,
        List<int> workHours,
      }) userModel);
}
