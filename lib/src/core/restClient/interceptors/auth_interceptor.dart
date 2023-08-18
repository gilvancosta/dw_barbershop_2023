import 'package:dio/dio.dart';
import 'package:dw_barbershop_2023/src/core/constants/local_storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final RequestOptions(:headers, :extra) = options;

    const authHeaderKey = 'Authorization';
    headers.remove(authHeaderKey);

    if (extra case {'DIO_AUTH_KEY': true}) {
      final sp = await SharedPreferences.getInstance();
      headers.addAll({authHeaderKey: 'bearer ${sp.getString(LocalStorageKeys.accessToken)}'});
    }

    handler.next(options);
  }
}
