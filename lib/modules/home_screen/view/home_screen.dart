import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_firebase/core/colors.dart';
import 'package:login_firebase/models/user_model.dart';
import 'package:login_firebase/modules/home_screen/viewmodel/home_controller.dart';
import 'package:login_firebase/modules/login/viewmodel/auth_controller.dart';
import 'package:login_firebase/widgets/labelediconbutton.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel?>(
      stream: Provider.of<AuthProvider>(context).readData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.data == null) {
          return Scaffold(
            body: Center(
                child: CupertinoActivityIndicator(
              color: blackColor,
              radius: 50,
            )),
          );
        } else {
          final UserModel user = snapshot.data;
          return Scaffold(
            key: _scaffoldKey,
            endDrawerEnableOpenDragGesture: false,
            appBar: AppBar(
                title: Text("Hi,${user.name!.toUpperCase()}"),
                backgroundColor: Colors.black,
                actions: [
                  IconButton(
                      onPressed: () {
                        context.read<AuthProvider>().logOut(context);
                      },
                      icon: const Icon(Icons.logout))
                ],
                leading: IconButton(
                  icon: user.image == null
                      ? const CircleAvatar(
                          backgroundImage:
                              AssetImage("images/download (1).png"),
                          radius: 50,
                        )
                      : CircleAvatar(
                          backgroundImage: MemoryImage(
                              const Base64Decoder().convert(user.image!)),
                          radius: 50,
                        ),
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                )),
            drawer: SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 1.8,
                child: Drawer(
                    child: ListView(
                  children: [
                    DrawerHeader(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: user.image == null
                                ? const AssetImage("images/download (1).png")
                                : MemoryImage(const Base64Decoder()
                                    .convert(user.image!)) as ImageProvider,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  context
                                      .read<HomeController>()
                                      .imageSelection(context, user);
                                },
                                icon: CircleAvatar(
                                    backgroundColor: blackColor,
                                    child: const Icon(Icons.draw_outlined)))
                          ],
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(user.name!.toUpperCase()),
                        IconButton(
                            onPressed: () {
                              context.read<HomeController>().editDialogBox(
                                  context, user, user.name!, "name");
                            },
                            icon: const Icon(Icons.edit))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(user.number == null
                            ? "ADD PHONE NUMBER"
                            : user.number!),
                        IconButton(
                            onPressed: () {
                              context.read<HomeController>().editDialogBox(
                                  context, user, user.number, "number");
                            },
                            icon: const Icon(Icons.edit))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("LOGOUT"),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor:
                                      const Color.fromARGB(15, 0, 0, 0),
                                  content: Text(
                                    "Are You sure?",
                                    style: TextStyle(color: whiteColor),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancel')),
                                    TextButton(
                                        onPressed: () {
                                          context
                                              .read<AuthProvider>()
                                              .logOut(context);
                                        },
                                        child: const Text('Confirm'))
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(Icons.logout))
                      ],
                    ),
                  ],
                )),
              ),
            ),
          );
        }
      },
    );
  }
}
