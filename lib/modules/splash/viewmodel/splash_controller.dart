import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:login_firebase/modules/login/view/signin_screen.dart';
import 'package:login_firebase/routes/routes.dart';

class SplashScreenController extends ChangeNotifier {
  bool isLoading = false;

  late AnimationController controller;
  late Animation<double> animation;

  SplashScreenController() {
    goToLoginPage();
    Timer(const Duration(seconds: 2), () {
      isLoading = true;
      notifyListeners();
    });
  }

  goToLoginPage() {
    Timer(const Duration(seconds: 6),
        () => RoutesManager.removeScreen(screen: const SignInScreen()));
  }
}
