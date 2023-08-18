import 'package:dw_barbershop_2023/src/core/fp/either.dart';
import 'package:dw_barbershop_2023/src/core/restClient/rest_client.dart';
import 'package:dw_barbershop_2023/src/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dw_barbershop_2023/src/repositories/user/user_repository.dart';
import 'package:dw_barbershop_2023/src/repositories/user/user_repository_impl.dart';

import 'package:dw_barbershop_2023/src/services/user_login/user_login_service.dart';
import 'package:dw_barbershop_2023/src/services/user_login/user_login_service_impl.dart';

part 'application_providers.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) => UserRepositoryImpl(restClient: ref.read(restClientProvider));

@Riverpod(keepAlive: true)
UserLoginService userLoginService(UserLoginServiceRef ref) => UserLoginServiceImpl(userRepository: ref.read(userRepositoryProvider));

@Riverpod(keepAlive: true)
Future<UserModel> getMe(GetMeRef ref) async {
  final result = await ref.watch(userRepositoryProvider).me();

  return switch (result) {
    Success(value: final userModel) => userModel,
    Failure(:final exception) => throw exception,
  };
}




/// Rodar o comando abaixo
///  dart run build_runner watch -d
/// 