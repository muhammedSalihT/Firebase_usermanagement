import 'package:flutter/material.dart';
import 'package:login_firebase/modules/home_screen/viewmodel/home_controller.dart';
import 'package:login_firebase/modules/login/viewmodel/auth_controller.dart';
import 'package:login_firebase/modules/login/viewmodel/signin_controller.dart';
import 'package:login_firebase/modules/signup/viewmodel/signup_controller.dart';
import 'package:login_firebase/modules/splash/view/splash_screen.dart';
import 'package:login_firebase/modules/splash/viewmodel/splash_controller.dart';
import 'package:login_firebase/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashScreenController()),
        ChangeNotifierProvider(create: (_)=>AuthProvider()),
        ChangeNotifierProvider(create: (_) =>SigninController()),
        ChangeNotifierProvider(create: (_) =>SignUpController()),
        StreamProvider(create: (context) => context.watch<AuthProvider>().stream(), initialData: null),
        ChangeNotifierProvider(create: (context) =>HomeController() ,)
      ],
      child: MaterialApp(
        navigatorKey: RoutesManager.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: const SplashScreen(),
      ),
    );
  }
}
