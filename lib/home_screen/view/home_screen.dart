import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/authentication/viewmodel/auth.dart';
import 'package:login_firebase/login/view/signin_screen.dart';
import 'package:login_firebase/widgets/text_form_widget.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('users');

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
                      context.read<AuthProvider>().logOut();
                    },
                    icon: const Icon(Icons.logout))
              ],
            ),
            body: FutureBuilder<bool>(
              future: isUserData(context),
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
                      Container(
                        child: TextField(
                          controller: nameController,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormWidget(
                        controller: numController,
                        hideData: false,
                        hint: "Your mobile number",
                        icon: Icons.phone_android,
                        label: "number",
                        textType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                          ),
                          onPressed: () async {
                            final name = nameController.text;
                            final double? phone =
                                double.tryParse(numController.text);

                            // nameController.text = "";
                            // numController.text = "";
                            final user = Provider.of<AuthProvider>(context)
                                .fb
                                .currentUser;
                            await _products
                                .doc(user!.uid)
                                .set({"name": name, "number": phone});
                          },
                          child: const Text("Save"),
                        ),
                      )
                    ],
                  );
                }
                return CircularProgressIndicator();
              },
            ));
      },
    );
  }

  Future<bool> isUserData(context) async {
    User? user = Provider.of<AuthProvider>(context).fb.currentUser;
    var a = await _products.doc(user!.uid).get();
    if (a.exists) {
      return true;
    }
    return false;
  }
}
