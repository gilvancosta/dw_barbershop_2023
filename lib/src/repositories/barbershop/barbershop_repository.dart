import 'package:dw_barbershop_2023/src/core/exceptions/repository_exception.dart';
import 'package:dw_barbershop_2023/src/core/fp/either.dart';
import 'package:dw_barbershop_2023/src/model/barbershop_model.dart';
import 'package:dw_barbershop_2023/src/model/user_model.dart';

abstract interface class BarbershopRepository {
  Future<Either<RepositoryException, BarbershopModel>> getMyBarbershop(UserModel userModel);
}
