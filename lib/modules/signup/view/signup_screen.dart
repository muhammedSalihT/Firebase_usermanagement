import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/core/colors.dart';
import 'package:login_firebase/modules/login/viewmodel/auth_controller.dart';
import 'package:login_firebase/modules/home_screen/view/home_screen.dart';
import 'package:login_firebase/modules/login/viewmodel/signin_controller.dart';
import 'package:login_firebase/modules/signup/viewmodel/signup_controller.dart';
import 'package:login_firebase/routes/routes.dart';
import 'package:login_firebase/widgets/company_title.dart';
// ignore: depend_on_referenced_packages
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:login_firebase/widgets/text_form_widget.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

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
                    flex: 6,
                    child: Card(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Column(
                            children: [
                              TextFormWidget(
                                controller:
                                    context.read<SignUpController>().name,
                                label: "Name",
                                hideData: false,
                                hint: "Your Name",
                                icon: Icons.password_rounded,
                                textType: TextInputType.name,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              TextFormWidget(
                                controller:
                                    context.read<SignUpController>().email,
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
                                    context.read<SignUpController>().pass,
                                label: "password",
                                hideData: context.read<SigninController>().hidePassword,
                                suffixIcon:context.watch<SigninController>().onTap(),
                                hint: "ENTER PASSWORD",
                                icon: Icons.password_rounded,
                                textType: TextInputType.number,
                              ),
                               const SizedBox(
                                height: 30,
                              ),
                               TextFormWidget(
                                controller:
                                    context.read<SignUpController>().rePass,
                                label: "Re enter password",
                                hideData: context.read<SigninController>().hidePassword,
                                suffixIcon:context.watch<SigninController>().onTap(),
                                hint: "ENTER PASSWORD",
                                icon: Icons.password_rounded,
                                textType: TextInputType.number,
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
                                const CupertinoActivityIndicator(radius: 20,),
                              if (!authProvider.loading)
                                SizedBox(
                                  width: size.width / 2,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.black,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<SignUpController>()
                                          .signUpHere(authProvider, context);
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
            return HomeScreen();
          }
        });
  }

 
}
