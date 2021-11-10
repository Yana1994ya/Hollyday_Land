import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/login.dart';

class ProfileScreen extends StatelessWidget {
  static const routePath = "/profile";

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    // if guest
    if (loginProvider.currentUser == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Profile"),),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Image(image: AssetImage('assets/graphics/logo.png')),
              const Text("You are not currently signed in."),
              ElevatedButton(
                child: const Text('Log in with Google'),
                onPressed: () {
                  loginProvider.signIn();
                },
              ),
            ],
          ),
        ),
      );
    } else {
      // if logged in
      return Scaffold(
        appBar: AppBar(title: Text("Login"),),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("welcome ${loginProvider.currentUser!.displayName}"),
              ElevatedButton(
                onPressed: () {
                  loginProvider.signOut();
                },
                child: Text("Log out"),
              ),
            ],
          ),
        ),
      );
    }
  }
}
