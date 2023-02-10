import 'package:http/http.dart' as http;
import 'dart:convert';

/// * получение токена авторизации и сессии от сервера elma.
/// Required to pass the method token and password to get data from elma
Future<Auth> getAuth(String token, String password, String host) async {
  var url = Uri.http(
      host, "/API/REST/Authorization/LoginWith", {"username": "admin"});

  var response = await http.post(url,
      headers: {
        "ApplicationToken": token,
        "Content-Type": "application/json; charset=utf-8"
      },
      body: password);

  var respJson = Auth.fromJson(jsonDecode(response.body));

  return respJson;
}

class Auth {
  String authToken;
  String currentUserId;
  String lang;
  String sessionToken;

  Auth(
      {required this.authToken,
      required this.currentUserId,
      required this.lang,
      required this.sessionToken});

  factory Auth.fromJson(dynamic json) {
    return Auth(
        authToken: json['AuthToken'] as String,
        currentUserId: json['CurrentUserId'] as String,
        lang: json['Lang'] as String,
        sessionToken: json['SessionToken'] as String);
  }
}
