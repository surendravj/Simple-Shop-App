import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  String token;
  DateTime expireDate;
  String id;

  bool get isAuth {
    return _token != null;
  }

  String get _token {
    if (expireDate != null &&
        expireDate.isAfter(DateTime.now()) &&
        token != null) {
      return token;
    }
    return null;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAyOyCpBa04vZ5g4R9fzQxyurUEZ9NgdHc';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {'email': email, 'password': password, 'returnSecureToken': true},
        ),
      );
      var responseData = json.decode(response.body);
      token = responseData['idToken'];
      id = responseData['localId'];
      expireDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
