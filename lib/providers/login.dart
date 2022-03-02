import "package:flutter/material.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:hollyday_land/api_server.dart";

class LoginProvider with ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ["email"],
  );

  GoogleSignInAccount? _currentUser;
  String? _hdToken;

  LoginProvider() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      if (account != null) {
        _hdLogin(account).then((token) {
          _currentUser = account;
          _hdToken = token;

          notifyListeners();
        });
      } else {
        notifyListeners();
      }
    });

    _googleSignIn.signInSilently();
  }

  Future<String> _hdLogin(GoogleSignInAccount account) async {
    final auth = await account.authentication;

    return ApiServer.post(
      "/attractions/api/login",
      "token",
      {
        "token": auth.idToken!,
      },
    ).then((value) => (value as String));
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

  Future<void> signOut() => _googleSignIn.disconnect().then((_) {
        _currentUser = null;
        _hdToken = null;
        notifyListeners();
      });

  String? get hdToken {
    return _hdToken;
  }

  Future<void> visit(int attractionId) async {
    // Visit is irrelevant for non-logged in users
    if (_hdToken == null) {
      return;
    }

    return ApiServer.voidPost(
      "/attractions/api/visit",
      {
        "token": _hdToken!,
        "id": attractionId,
      },
    );
  }
}
