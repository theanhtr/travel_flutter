import 'dart:convert';

import 'package:http/http.dart' as http;

const String baseUrl =
    "https://aade-2405-4802-1d30-4ee0-982b-3c7c-f97c-da5a.ngrok-free.app/api";

class BaseClient {
  var client = http.Client();
  String tokenAuth = "";
  var _header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  BaseClient(String tokenAuthParam) {
    tokenAuth = tokenAuthParam;
    if (tokenAuth != "") {
      _header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $tokenAuth',
      };
    } else {
      _header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
    }
  }

  Future<dynamic> get(String api) async {
    var url = Uri.parse(baseUrl + api);

    var response = await client.get(url, headers: _header);

    if (response.statusCode == 200) {
      return response.body;
    } else {}
  }

  Future<dynamic> post(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var payload = json.encode(object);

    var response = await client.post(url, body: payload, headers: _header);

    if (response.statusCode == 201 ||
        response.statusCode == 204 ||
        response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  Future<dynamic> patch(String api) async {}

  Future<dynamic> put(String api) async {}

  Future<dynamic> delete(String api) async {}
}
