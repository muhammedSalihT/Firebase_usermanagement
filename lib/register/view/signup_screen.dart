import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/authentication/viewmodel/auth.dart';
import 'package:login_firebase/core/colors.dart';
import 'package:login_firebase/home_screen/view/home_screen.dart';
import 'package:login_firebase/routes/routes.dart';
import 'package:login_firebase/widgets/company_title.dart';
// ignore: depend_on_referenced_packages
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:login_firebase/widgets/text_form_widget.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _RegisterScreeenState();
}

class _RegisterScreeenState extends State<SignUpScreen> {
  final TextEditingController email = TextEditingController(),
  name = TextEditingController(),
      pass = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    super.dispose();
  }

  void signUpHere(AuthProvider provider) async {
    final msg = await provider.signUp(email.text, pass.text);
    if (msg == "") return;

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg.trim())));
    log(msg);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authProvider = context.watch<AuthProvider>();

    return StreamBuilder<User?>(
        stream: context.watch<AuthProvider>().stream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  Expanded(
                    flex: 2,
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
                    flex: 4,
                    child: Card(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Column(
                            children: [
                              const SizedBox(height: 30,),
                              TextFormWidget(
                                controller: email,
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
                                controller: pass,
                                label: "password",
                                hideData: true,
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
                                        RoutesManager.backScreen();
                                      },
                                      child: Text(
                                        "Already Here! Login?",
                                        style: TextStyle(color: blackColor),
                                      ),
                                    ),
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
                                      signUpHere(authProvider);
                                    },
                                    child: const Text("Sign Up"),
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
            return  HomeScreen();
          }
        });
  }
}
