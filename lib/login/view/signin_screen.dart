import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/authentication/viewmodel/auth.dart';
import 'package:login_firebase/core/colors.dart';
import 'package:login_firebase/home_screen/view/home_screen.dart';
import 'package:login_firebase/register/view/signup_screen.dart';
import 'package:login_firebase/routes/routes.dart';
import 'package:login_firebase/widgets/company_title.dart';
// ignore: depend_on_referenced_packages
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:login_firebase/widgets/text_form_widget.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _email = TextEditingController(),
      _pass = TextEditingController();

  @override
  void dispose() {
    log('message');
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  void signInHere(AuthProvider provider) async {
    mainEmail = _email.text;
    final msg = await provider.signIn(_email.text, _pass.text);
    if (msg == "") {
      return;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(msg.trim())));
      log(msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authProvider = context.watch<AuthProvider>();

    return StreamBuilder<User?>(
        stream: context.watch<AuthProvider>().stream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Column(
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
                              controller: _email,
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
                              controller: _pass,
                              label: "password",
                              hideData: false,
                              hint: "ENTER PASSWORD",
                              icon: Icons.password_rounded,
                              textType: TextInputType.name,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
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
                                          style: TextStyle(color: blackColor))),
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
                                    signInHere(authProvider);
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
            );
          } else {
            return HomeScreen();
          }
        });
  }
}
