import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../config.dart';

class LoginProvider with ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
    scopes: <String>['email'],
  );

  GoogleSignInAccount? _currentUser;
  String? _hdToken;

  LoginProvider() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      if (account != null) {
        hdLogin(account).then((token){
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

  Future<String> hdLogin(GoogleSignInAccount account) async {
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
        throw Exception("error was returned:${data["error"]}");
      }
    } else {
      throw Exception("failed to load data, status: ${response.statusCode}");
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

  Future<void> signOut() => _googleSignIn.disconnect();

  String? get hdToken {
    return _hdToken;
  }

  Future<void> visit(int attractonId) async {
    // Visit is irrelavent for non-loged in users
    if(_hdToken == null){
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
        <String, String>{
          'token': _hdToken!,
          'id': attractonId.toString()
        },
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data["status"] != "ok") {
        throw Exception("error was returned:${data["error"]}");
      }
    } else {
      throw Exception("failed to load data, status: ${response.statusCode}");
    }
  }
}
