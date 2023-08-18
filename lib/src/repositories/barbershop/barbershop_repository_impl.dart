import 'package:dio/dio.dart';
import 'package:dw_barbershop_2023/src/core/exceptions/repository_exception.dart';
import 'package:dw_barbershop_2023/src/core/fp/either.dart';
import 'package:dw_barbershop_2023/src/core/restClient/rest_client.dart';
import 'package:dw_barbershop_2023/src/model/barbershop_model.dart';
import 'package:dw_barbershop_2023/src/model/user_model.dart';
import 'package:dw_barbershop_2023/src/repositories/barbershop/barbershop_repository.dart';

class BarbershopRepositoryImpl implements BarbershopRepository {
  final RestClient restClient;
  BarbershopRepositoryImpl({
    required this.restClient,
  });

  @override
  Future<Either<RepositoryException, BarbershopModel>> getMyBarbershop(UserModel userModel) async {
    switch (userModel) {
      case UserModelADM():
        final Response(data: List(first: data)) = await restClient.auth.get(
          '/barbershop',
          queryParameters: {'user_id': '#userAuthRef'},
        );
        return Success(BarbershopModel.fromMap(data));
      case UserModelEmployee():
        final Response(:data) = await restClient.auth.get(
          '/barbershop/${userModel.barbershopId}',
        );
        return Success(BarbershopModel.fromMap(data));
    }
  }
}
