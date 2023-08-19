import 'package:dw_barbershop_2023/src/core/ui/barbershop_nav_global_key.dart';
import 'package:dw_barbershop_2023/src/core/ui/barbershop_theme.dart';
import 'package:dw_barbershop_2023/src/core/ui/widgets/barbershop_loader.dart';
import 'package:dw_barbershop_2023/src/features/splash/auth/login/login_page.dart';
import 'package:dw_barbershop_2023/src/features/splash/auth/register/barbershop/barbershop_register_page.dart';
import 'package:dw_barbershop_2023/src/features/splash/auth/register/user/user_register_page.dart';
import 'package:dw_barbershop_2023/src/features/splash/splash/splash_page.dart';

import 'package:flutter/material.dart';
import 'package:asyncstate/widget/async_state_builder.dart';

class BarbershopApp extends StatelessWidget {
  const BarbershopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const BarbershopLoader(),
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          title: 'DW Barbershop',
          theme: BarbershopTheme.themeData,
          navigatorObservers: [asyncNavigatorObserver],
          navigatorKey: BarbershopNavGlobalKey.instance.navkey,
          routes: {
            '/': (_) => const SplashPage(),
            '/auth/login': (_) => const LoginPage(),
            '/auth/register/user': (_) => const UserRegisterPage(),
            '/auth/register/barbershop': (_) => const BarbershopRegisterPage(),
            '/home/adm': (_) => const Center(child: Text('ADM')),
            '/home/employee': (_) => const Text('Employee'),
          },
        );
      },
    );
  }
}
