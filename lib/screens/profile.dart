import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../providers/login.dart';
import 'login.dart';

typedef void LoginFunction();
typedef void LogoutFunction();

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static Widget _buildLoggedIn(LoginProvider loginProvider) {
    final user = loginProvider.currentUser!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        ListTile(
          leading: GoogleUserCircleAvatar(
            identity: user,
          ),
          title: Text(user.displayName ?? ''),
          subtitle: Text(user.email),
        ),
        const Text("Signed in successfully."),
        Text("Hello ${user.displayName}"),
        Text(user.id),
        ElevatedButton(
          child: const Text('Log out'),
          onPressed: () {
            loginProvider.signOut();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return loginProvider.currentUser == null
        ? LoginScreen(reason: "Please login to see your profile")
        : _buildLoggedIn(loginProvider);
  }
}
