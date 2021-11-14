import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hollyday_land/models/http_exception.dart';
import 'package:hollyday_land/models/login_exception.dart';
import 'package:http/http.dart' as http;

import '../config.dart';

class LoginProvider with ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
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
    final uri = Uri.https(API_SERVER, "/attractions/api/login");
    final auth = await account.authentication;

    print("fetching: $uri");

    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'token': auth.idToken!,
        },
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data["status"] == "ok") {
        return data["token"];
      } else {
        throw LoginException("error was returned:${data["error"]}");
      }
    } else {
      throw LoginException(
          "failed to load data, status: ${response.statusCode}");
    }
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
      });

  String? get hdToken {
    return _hdToken;
  }

  Future<void> visit(int attractonId) async {
    // Visit is irrelavent for non-loged in users
    if (_hdToken == null) {
      return;
    }

    final uri = Uri.https(API_SERVER, "/attractions/api/visit");

    print("fetching: $uri");

    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{'token': _hdToken!, 'id': attractonId},
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data["status"] != "ok") {
        throw HttpException("error was returned:${data["error"]}");
      }
    } else {
      throw HttpException(
          "failed to load data, status: ${response.statusCode}");
    }
  }
}
