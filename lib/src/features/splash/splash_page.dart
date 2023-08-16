// import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop_2023/src/features/splash/auth/login/login_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var _scale = 10.0;
  final _animationDuration = const Duration(milliseconds: 3000);
  var _animationOpacityLogo = 0.0;

  double get _logoAnimationWidth => _scale * 100;
  double get _logoAnimationHeight => _scale * 120;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _animationOpacityLogo = 1.0;
        _scale = 1.0;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_image_chair.jpg'),
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
        ),
        child: Center(
          child: AnimatedOpacity(
              opacity: _animationOpacityLogo,
              curve: Curves.easeIn,
              duration: _animationDuration,
              //-----------------
              onEnd: () {
                Navigator.of(context).pushAndRemoveUntil(
                    PageRouteBuilder(
                      settings: const RouteSettings(name: 'auth/login'),
                      pageBuilder: (
                        context,
                        animation,
                        secondaryAnimation,
                      ) {
                        return const LoginPage();
                      },
                      transitionsBuilder: (
                        context,
                        animation,
                        secondaryAnimation,
                        child,
                      ) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                    (route) => false);
              },

              //---------------------
              child: AnimatedContainer(
                duration: _animationDuration,
                width: _logoAnimationWidth,
                height: _logoAnimationHeight,
                curve: Curves.linearToEaseOut,
                child: Image.asset(
                  'assets/images/imgLogo.png',
                  fit: BoxFit.cover,
                ),
              )),
        ), // tive que adicionar para a imagem aparecer
      ),
    );
  }
}
