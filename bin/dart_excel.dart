import 'dart:convert';

import 'package:dart_elma/auth/auth.dart';
import 'package:dart_elma/get.env.dart' as envModule;
import 'package:http/http.dart' as http;

void main(List<String> arguments) async {
  var env = await envModule.getEnv();
  var token = env["TOKEN"];
  var password = env["PASSWORD"];
  var host = env["HOST"];

  var auth = await getAuth(token ?? "", password ?? "", host ?? "");

  String groupsTypeUid = "1b5dca14-da97-4a7e-816f-b3531276149c";

  //  Url: http://127.0.0.1:8000/API/REST/Entity/Load?type={TYPEUID}&id={ENTITYID}

  var urlGetGroups = Uri.http(host ?? "", "API/REST/Entity/Query",
      {"type": groupsTypeUid, "limit": "2"});

  print(urlGetGroups);

  var resp = await http.get(urlGetGroups, headers: {
    "AuthToken": auth.authToken,
    "SessionToken": auth.sessionToken,
    "Content-Type": "application/json; charset=utf-8"
  });

  var body = jsonDecode(resp.body);

  print(body["Value"]);
}
