import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './profile.dart';

class FavoritesWidget extends StatelessWidget {
  final GoogleSignInAccount? currentUser;
  final LoginFunction loginFunction;

  const FavoritesWidget(
      {required this.currentUser, required this.loginFunction});

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return ProfilePage.buildGuest(loginFunction);
    } else {
      return Text("favorites");
    }
  }
}
