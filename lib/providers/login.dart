import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginProvider with ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
    scopes: <String>['email'],
  );

  GoogleSignInAccount? _currentUser;

  LoginProvider() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      _currentUser = account;
      notifyListeners();
    });

    _googleSignIn.signInSilently();
  }

  GoogleSignInAccount? get currentUser {
    return _currentUser;
  }

  Future<void> signIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> signOut() => _googleSignIn.disconnect();
}
