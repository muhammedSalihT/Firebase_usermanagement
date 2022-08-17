import 'package:flutter/material.dart';
import 'package:login_firebase/core/colors.dart';
// ignore: depend_on_referenced_packages
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:login_firebase/modules/splash/viewmodel/splash_controller.dart';
import 'package:login_firebase/widgets/company_title.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
 
 

  @override
  initState() {
    super.initState();
    context.read<SplashScreenController>().controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    context.read<SplashScreenController>().animation =
        CurvedAnimation(parent: context.read<SplashScreenController>().controller, curve: Curves.bounceInOut);

    context.read<SplashScreenController>().controller.forward();
  }

  // @override
  // dispose() {
  //   context.read<SplashScreenController>().controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: scaffoldColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: context.read<SplashScreenController>().animation,
            alignment: Alignment.center,
            child:const  CompanyTitle(broColor:blackColor,size: 50,containerColor:whiteColor ,typeColor: whiteColor),
          ),
          if (context.watch<SplashScreenController>().isLoading)...[
            AnimatedTextKit(
              isRepeatingAnimation: false,
              animatedTexts: [
                TypewriterAnimatedText(' BROTHER YOU NEVER HAD',
                    textStyle: const TextStyle(
                        fontSize: 20,
                        decoration: TextDecoration.none,
                        color: Colors.white),
                    speed: const Duration(milliseconds: 150)),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

