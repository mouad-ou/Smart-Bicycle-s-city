import 'package:bicycle_renting/pages/bicyclesList/bicyclesListPage.dart';
import 'package:bicycle_renting/services/authService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Banner/Banner.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 126, 230),
          foregroundColor: Colors.white,
          title: const Text("bicycle Renting"),
        ),
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  DrawerHeader(
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                      ), //BoxDecoration
                      child: UserAccountsDrawerHeader(
                          decoration: const BoxDecoration(color: Colors.blue),
                          accountName: Text(
                            FirebaseAuth.instance.currentUser?.displayName ??
                                '',
                            style: const TextStyle(fontSize: 16),
                          ),
                          accountEmail: Text(
                            FirebaseAuth.instance.currentUser?.email ?? '',
                          ),
                          currentAccountPictureSize: const Size.square(45),
                          currentAccountPicture: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(255, 0, 217, 255),
                            child: Text(
                              FirebaseAuth.instance.currentUser!.displayName?[0]
                                      .toUpperCase() ??
                                  "",
                              style: const TextStyle(
                                  fontSize: 30.0, color: Colors.blue),
                            ),
                          ))),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Profile'),
                    onTap: () {
                      // Navigator.pop(context);
                    },
                  ),
                ],
              ),
              ListTile(
                leading: const Icon(Icons.logout_outlined),
                title: const Text('Logout'),
                onTap: () async {
                  try {
                    await authService.signOutUser();
                    if (mounted) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(

                            builder: (context) =>  MyBanner()),
                      );
                    }
                  } catch (e) {}
                },
              ),
            ],
          ),
        ), //Drawer,
        body: const bicyclesListPage());
  }
}
