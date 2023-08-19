import 'package:dw_barbershop_2023/src/core/constants/constants.dart';
import 'package:dw_barbershop_2023/src/core/features/splash/auth/login/login_state.dart';
import 'package:dw_barbershop_2023/src/core/features/splash/auth/login/login_vm.dart';
import 'package:dw_barbershop_2023/src/core/ui/helpers/form_helper.dart';
import 'package:dw_barbershop_2023/src/core/ui/helpers/messages.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginVm(:login) = ref.watch(loginVmProvider.notifier);

    ref.listen(loginVmProvider, (_, state) {
      switch (state) {
        case LoginState(status: LoginStateStatus.initial):
          break;
        case LoginState(status: LoginStateStatus.error, :final errorMessage?):
          Messages.showError(errorMessage, context);
        case LoginState(status: LoginStateStatus.error):
          Messages.showError('Erro ao realizar login', context);
        case LoginState(status: LoginStateStatus.admLogin):
          Navigator.of(context).pushNamedAndRemoveUntil('/home/adm', (route) => false);
          break;
        case LoginState(status: LoginStateStatus.employeeLogin):
          Navigator.of(context).pushNamedAndRemoveUntil('/home/employee', (route) => false);
          break;
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: formKey,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstants.backgroundChair),
              fit: BoxFit.cover,
              opacity: 0.2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(ImageConstants.imageLogo),
                          const SizedBox(height: 30),
                          TextFormField(
                            onTapOutside: (_) => context.unfocus(),
                            validator: Validatorless.multiple([
                              Validatorless.required('E-mail obrigatório'),
                              Validatorless.email('E-mail inválido'),
                            ]),
                            controller: emailEC,
                            decoration: const InputDecoration(
                              label: Text('E-mail'),
                              hintText: 'Digite seu login',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            onTapOutside: (event) => context.unfocus(),
                            validator: Validatorless.multiple([Validatorless.required('Senha obrigatório'), Validatorless.min(6, 'Senha deve ter no mínimo 6 caracteres')]),
                            obscureText: true,
                            controller: passwordEC,
                            decoration: const InputDecoration(
                              label: Text('Senha'),
                              hintText: 'Digite sua senha',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Esqueceu a senha?',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(56),
                            ),
                            onPressed: () {
                              switch (formKey.currentState!.validate()) {
                                case (false):
                                  Messages.showError('Preencha os campos corretamente', context);
                                  break;
                                case true:
                                  login(emailEC.text, passwordEC.text);
                                  break;
                              }
                            },
                            child: const Text('ACESSAR'),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: () => Navigator.of(context).pushNamed('/auth/register/user'),
                          child: const Text(
                            'Criar Conta',
                            style: TextStyle(
                               color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
