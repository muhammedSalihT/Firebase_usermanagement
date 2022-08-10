import 'dart:async';
import 'package:flutter/material.dart';
import 'package:login_firebase/core/colors.dart';
// ignore: depend_on_referenced_packages
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:login_firebase/login/view/signin_screen.dart';
import 'package:login_firebase/routes/routes.dart';
import 'package:login_firebase/widgets/company_title.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  bool _isLoading = false;

  late AnimationController _controller;
  late Animation<double> _animation;

  initState() {
    super.initState();
    goToLoginPage();
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = true;
      });
    });
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);

    _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            scale: _animation,
            alignment: Alignment.center,
            child: CompanyTitle(broColor:blackColor,size: 50,containerColor:whiteColor ,typeColor: whiteColor),
          ),
          if (_isLoading) ...[
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

  goToLoginPage() {
    Timer(const Duration(seconds: 6),
        () => RoutesManager.removeScreen(screen: const SignInScreen()));
  }
}

