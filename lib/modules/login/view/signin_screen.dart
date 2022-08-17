import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/core/colors.dart';
import 'package:login_firebase/modules/login/viewmodel/auth_controller.dart';
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
          if (snapshot.data == null) {
            return Scaffold(
              body: Column(
                children: [
                  Container(
                    width: size.width,
                    height: size.height * .4,
                    decoration: const BoxDecoration(
                        color: blackColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CompanyTitle(
                            size: 50,
                            broColor: blackColor,
                            containerColor: whiteColor,
                            typeColor: whiteColor),
                        AnimatedTextKit(
                          isRepeatingAnimation: true,
                          totalRepeatCount: 100,
                          animatedTexts: [
                            TypewriterAnimatedText(' BROTHER YOU NEVER HAD',
                                textStyle: const TextStyle(
                                    fontSize: 20,
                                    decoration: TextDecoration.none,
                                    color: whiteColor),
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
                          Form(
                            key: context.read<SigninController>().formKey,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 60,
                                ),
                                TextFormWidget(
                                  errorMessege: "enter password",
                                  textColor: blackColor,
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
                                  errorMessege: "enter password",
                                  textColor: blackColor,
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
                                        child: const Text(
                                          "New Here! Register?",
                                          style: TextStyle(color: blackColor),
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () {},
                                          child: const Text("Forget Password?",
                                              style:
                                                  TextStyle(color: blackColor))),
                                    ],
                                  ),
                                ),
                                if (authProvider.loading)
                                  const CupertinoActivityIndicator(),
                                if (!authProvider.loading)
                                  SizedBox(
                                    width: size.width / 2,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: const Color.fromARGB(
                                            255, 48, 211, 132),
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
