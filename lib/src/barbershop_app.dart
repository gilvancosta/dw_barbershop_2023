import 'package:dw_barbershop_2023/src/core/ui/widgets/barbershop_loader.dart';
import 'package:flutter/material.dart';
import 'package:asyncstate/widget/async_state_builder.dart';

import 'package:dw_barbershop_2023/src/features/splash/splash_page.dart';

class BarbershopApp extends StatelessWidget {
  const BarbershopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const BarbershopLoader(),
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          title: 'DW Barbershop',
          navigatorObservers: [asyncNavigatorObserver],
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            '/': (context) => const SplashPage(),
            // '/login': (context) => const LoginPage(),
            //'/register': (context) => const RegisterPage(),
            // '/barbershop': (context) => const BarbershopPage(),
            // '/barbershop/barber': (context) => const BarberPage(),
            // '/barbershop/barber/schedule': (context) => const SchedulePage(),
            // '/barbershop/barber/schedule/confirm': (context) => const ConfirmPage(),
            // '/barbershop/barber/schedule/confirmed': (context) => const ConfirmedPage(),
          },
        );
      },
    );
  }
}
