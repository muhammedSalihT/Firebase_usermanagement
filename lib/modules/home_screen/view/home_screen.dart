import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/models/auth_model/auth.dart';
import 'package:login_firebase/modules/login/view/signin_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final numController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: Provider.of<AuthProvider>(context).fb.userChanges(),
      builder: (context, snapshot) {
        User? user = snapshot.data;

        if (user == null) {
          return const SignInScreen();
        }

        return Scaffold(
            appBar: AppBar(
              title: const Text("WELCOME"),
              backgroundColor: Colors.black,
              actions: [
                IconButton(
                    onPressed: () {
                      context.read<AuthProvider>().logOut(context);
                    },
                    icon: const Icon(Icons.logout))
              ],
            ),
            body: FutureBuilder<User?>(
              future: getUser(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  bool isExist = snapshot.data!;
                  if (isExist) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Center(child: Text('hbh'))],
                    );
                  }
                  return Column(
                    children: [
                      const Center(
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Color.fromRGBO(0, 0, 0, 0),
                            backgroundImage: AssetImage("images/download.png")),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(""),
                      Text("data")
                    ],
                  );
                }
                return const CircularProgressIndicator();
              },
            ));
      },
    );
  }

  
}
