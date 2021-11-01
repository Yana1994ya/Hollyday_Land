import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/login.dart';

class LoginScreen extends StatelessWidget {
  final String reason;

  const LoginScreen({Key? key, required this.reason}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Image(image: AssetImage('assets/graphics/logo3.png')),
          const Text("You are not currently signed in."),
          Text(reason),
          ElevatedButton(
            child: const Text('Log in with Google'),
            onPressed: () {
              loginProvider.signIn();
            },
          ),
        ],
      ),
    );
  }
}
