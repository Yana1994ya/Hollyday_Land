import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

typedef void LoginFunction();
typedef void LogoutFunction();

class ProfilePage extends StatelessWidget {
  final GoogleSignInAccount? currentUser;
  final LoginFunction loginFunction;
  final LogoutFunction logoutFunction;

  const ProfilePage({
    required this.currentUser,
    required this.loginFunction,
    required this.logoutFunction,
  });

  Widget buildLoggedIn(GoogleSignInAccount user) {
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
          onPressed: logoutFunction,
        ),
      ],
    );
  }

  static Widget buildGuest(LoginFunction loginFunction) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Image(image: AssetImage('assets/graphics/logo.png')),
          const Text("You are not currently signed in."),
          ElevatedButton(
            child: const Text('Log in with Google'),
            onPressed: loginFunction,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return currentUser == null
        ? buildGuest(loginFunction)
        : buildLoggedIn(currentUser!);
  }
}
