import "package:flutter/material.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/login_response.dart";

class LoginProvider with ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ["email"],
  );

  GoogleSignInAccount? _currentUser;
  String? _hdToken;
  String? _userId;

  LoginProvider() {
    _googleSignIn.onCurrentUserChanged.listen(_performLogin);

    _googleSignIn.signInSilently();
  }

  void _performLogin(GoogleSignInAccount? account) {
    if (account != null) {
      _hdLogin(account).then((response) {
        _currentUser = account;
        _hdToken = response.token;
        _userId = response.userId;

        notifyListeners();
      });
    } else {
      notifyListeners();
    }
  }

  Future<LoginResponse> _hdLogin(GoogleSignInAccount account) async {
    final auth = await account.authentication;

    return ApiServer.post(
      "/attractions/api/login",
      "user",
      {
        "token": auth.idToken!,
      },
    ).then((value) => LoginResponse.fromJson(value));
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
        _userId = null;
        notifyListeners();
      });

  String? get hdToken {
    return _hdToken;
  }

  String? get userId {
    return _userId;
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
