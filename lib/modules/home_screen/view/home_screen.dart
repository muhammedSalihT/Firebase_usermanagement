import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_firebase/core/colors.dart';
import 'package:login_firebase/models/user_model.dart';
import 'package:login_firebase/modules/home_screen/viewmodel/home_controller.dart';
import 'package:login_firebase/modules/login/viewmodel/auth_controller.dart';
import 'package:login_firebase/modules/login/view/signin_screen.dart';
import 'package:login_firebase/widgets/labelediconbutton.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
          body: StreamBuilder<UserModel>(
              stream: Provider.of<AuthProvider>(context).readData(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  final UserModel user = snapshot.data;
                  return ListView(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Consumer<HomeController>(
                          builder: (context, value, child) => Stack(
                                children: [
                                  user.image.toString().isEmpty
                                      ? CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "images/download (1).png"),
                                          radius: 50,
                                        )
                                      : CircleAvatar(
                                          backgroundImage: MemoryImage(
                                              Base64Decoder()
                                                  .convert(user.image!)),
                                          radius: 50,
                                        ),
                                  IconButton(
                                      padding:
                                          EdgeInsets.only(top: 50, left: 50),
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                height: 80,
                                                width: double.infinity,
                                                color: whiteColor,
                                                child: Column(
                                                  children: [
                                                    const Text(
                                                        'choose your profile photo'),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        LabeledIconButton(
                                                            icon: Icons.camera,
                                                            label: "Camera",
                                                            onPress: () {
                                                              value.pickImageFromCamera(
                                                                  ImageSource
                                                                      .camera,user.email.toString());
                                                            }),
                                                        LabeledIconButton(
                                                            icon: Icons
                                                                .store_mall_directory,
                                                            label: "Storage",
                                                            onPress: () {}),
                                                        LabeledIconButton(
                                                            icon: Icons.delete,
                                                            label:
                                                                "Delete photo",
                                                            onPress: () {}),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      icon: CircleAvatar(
                                          backgroundColor: blackColor,
                                          child: Icon(Icons.draw_outlined)))
                                ],
                              )),
                      Text("name:${user.name}"),
                      Text("Email:${user.email}"),
                    ],
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        );
      },
    );
  }
}
