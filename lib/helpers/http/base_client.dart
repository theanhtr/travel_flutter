import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String baseUrl = "http://192.168.1.244:9000/api";

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

  static Future<bool> isConnectNetWork(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup(baseUrl);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return true;
  }

  static showErrorNetWork(BuildContext context) {
    BaseClient.isConnectNetWork(context).then((value) => {
      if (value == false) {
        showDialog(context: context, builder: (BuildContext context) => AlertDialog(
          title: const Text('ERROR NETWORK'),
          content: const Text('Can not connect to server'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),)
      }
    });
  }

  Future<dynamic> get(String api) async {
    var url = Uri.parse(baseUrl + api);

    var response = await client.get(url, headers: _header);

    if (response.statusCode == 200) {
      return response.body;
    } else {
    }
  }

  Future<dynamic> post(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var payload = json.encode(object);

    var response = await client.post(url, body: payload, headers: _header);

    if (response.statusCode == 201 || response.statusCode == 204
        || response.statusCode == 200
    ) {
      return response.body;
    } else {
      return response.statusCode;
    }
  }

  Future<dynamic> patch(String api) async {}

  Future<dynamic> put(String api) async {}

  Future<dynamic> delete(String api) async {}
}
