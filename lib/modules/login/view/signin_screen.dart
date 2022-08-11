import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/core/colors.dart';
import 'package:login_firebase/models/auth_model/auth.dart';
import 'package:login_firebase/modules/home_screen/view/home_screen.dart';
import 'package:login_firebase/modules/signup/view/signup_screen.dart';
import 'package:login_firebase/routes/routes.dart';
import 'package:login_firebase/widgets/company_title.dart';
// ignore: depend_on_referenced_packages
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:login_firebase/widgets/text_form_widget.dart';
import 'package:provider/provider.dart';
import '../viewmodel/signin_controller.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final authProvider = context.watch<AuthProvider>();

    return StreamBuilder<User?>(
        stream: context.watch<AuthProvider>().stream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: Column(
                children: [
                  Container(
                    width: size.width,
                    height: size.height * .3,
                    color: whiteColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CompanyTitle(
                            size: 40,
                            broColor: whiteColor,
                            containerColor: blackColor,
                            typeColor: blackColor),
                        AnimatedTextKit(
                          isRepeatingAnimation: true,
                          totalRepeatCount: 100,
                          animatedTexts: [
                            TypewriterAnimatedText(' BROTHER YOU NEVER HAD',
                                textStyle: TextStyle(
                                    fontSize: 20,
                                    decoration: TextDecoration.none,
                                    color: blackColor),
                                speed: const Duration(milliseconds: 150)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Drawer(
                      backgroundColor: whiteColor,
                      width: size.width,
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              const SizedBox(
                                height: 60,
                              ),
                              TextFormWidget(
                                controller:
                                    context.read<SigninController>().email,
                                label: "Email",
                                hideData: false,
                                hint: "ENTER YOUR EMAIL",
                                icon: Icons.email_outlined,
                                textType: TextInputType.multiline,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              TextFormWidget(
                                controller:
                                    context.read<SigninController>().pass,
                                label: "password",
                                hideData: context
                                    .read<SigninController>()
                                    .hidePassword,
                                suffixIcon:
                                    context.watch<SigninController>().onTap(),
                                hint: "ENTER PASSWORD",
                                icon: Icons.password_rounded,
                                textType: TextInputType.name,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        RoutesManager.nextScreen(
                                            screen: const SignUpScreen());
                                      },
                                      child: Text(
                                        "New Here! Register?",
                                        style: TextStyle(color: blackColor),
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {},
                                        child: Text("Forget Password?",
                                            style:
                                                TextStyle(color: blackColor))),
                                  ],
                                ),
                              ),
                              if (authProvider.loading)
                                const CircularProgressIndicator(),
                              if (!authProvider.loading)
                                SizedBox(
                                  width: size.width / 2,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.black,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<SigninController>()
                                          .signInHere(authProvider, context);
                                    },
                                    child: const Text("Sign In"),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return HomeScreen();
          }
        });
  }
}
