import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:vistoria_cfc/src/config/custom_colors.dart';
import 'package:vistoria_cfc/src/pages/auth/controller/auth_controller.dart';
import 'package:vistoria_cfc/src/pages/common_widgets/custom_text_field.dart';
import 'package:vistoria_cfc/src/services/utils_services.dart';
import 'package:vistoria_cfc/src/services/validators.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  // Controlador de campos
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      //backgroundColor: CustomColors.customSwatchColor,
      body: Stack(children: [
        Positioned.fill(
          child: Image.asset(
            "assets/fundo_device.png",
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            color: Colors.green.shade300.withOpacity(0.5),
          ),
        ),
        SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        height: 200,
                        width: 200,
                      ),
                      const Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontSize: 25,
                          ),
                          children: [
                            TextSpan(
                              text: 'CRT VISTORIA',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Banner
                      SizedBox(
                        height: 30,
                        child: DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                          child: AnimatedTextKit(
                            pause: Duration.zero,
                            repeatForever: true,
                            animatedTexts: [
                              FadeAnimatedText('Confiabilidade'),
                              FadeAnimatedText('Agilidade'),
                              FadeAnimatedText('Rapidez'),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                // Formulário
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 40,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(45),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Email
                        CustomTextField(
                          controller: usernameController,
                          icon: Icons.email,
                          label: 'Email',
                          validator: emailValidator,
                        ),

                        // Senha
                        CustomTextField(
                          controller: passwordController,
                          icon: Icons.lock,
                          label: 'Senha',
                          isSecret: true,
                          validator: passwordValidator,
                        ),

                        // Botão de entrar
                        SizedBox(
                          height: 50,
                          child: GetX<AuthController>(
                            builder: (authController) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      CustomColors.customSwatchColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                onPressed: authController.isLoading.value
                                    ? null
                                    : () {
                                        FocusScope.of(context).unfocus();
                                        if (_formKey.currentState!.validate()) {
                                          String username =
                                              usernameController.text;
                                          String password =
                                              passwordController.text;
                                          authController.signIn(
                                              username: username,
                                              password: password);
                                        }
                                      },
                                child: authController.isLoading.value
                                    ? const CircularProgressIndicator()
                                    : const Text(
                                        'Entrar',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
