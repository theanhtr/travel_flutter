import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String baseUrl =
    "https://b671-113-190-143-99.ngrok-free.app/api";

class BaseClient {
  String baseUrlForImport = baseUrl;
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

  static Future<bool> _isConnectNetWork(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup(
          baseUrl.substring(0, baseUrl.length - 4));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return true;
  }

  static showErrorNetWork(BuildContext context) {
    BaseClient._isConnectNetWork(context).then((value) => {
          debugPrint(value.toString()),
          // if (value == false) {
          //   showDialog(context: context, builder: (BuildContext context) => AlertDialog(
          //     title: const Text('ERROR NETWORK'),
          //     content: const Text('Can not connect to server'),
          //     actions: <Widget>[
          //       TextButton(
          //         onPressed: () => Navigator.pop(context, 'Cancel'),
          //         child: const Text('Cancel'),
          //       ),
          //       TextButton(
          //         onPressed: () => Navigator.pop(context, 'OK'),
          //         child: const Text('OK'),
          //       ),
          //     ],
          //   ),)
          // }
        });
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
      return response.statusCode;
    }
  }

  Future<dynamic> postHaiAnhDung(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var payload = json.encode(object);

    var response = await client.post(url, body: payload, headers: _header);
    debugPrint(response.body.toString());
    debugPrint("dong 104 base client");
    print(response.body.runtimeType);
    if (response.statusCode == 201 ||
        response.statusCode == 204 ||
        response.statusCode == 200) {
      return response.body.toString();
    } else {
      return response.body.toString();
    }
  }

  Future<dynamic> put(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var payload = json.encode(object);

    var response = await client.put(url, body: payload, headers: _header);
    debugPrint(response.body.toString());
    // debugPrint("dong 122 base client");
    // print(response.body.runtimeType);
    if (response.statusCode == 201 ||
        response.statusCode == 204 ||
        response.statusCode == 200) {
      return response.body.toString();
    } else {
      return response.body.toString();
    }
  }

  Future<dynamic> patch(String api) async {}

  Future<dynamic> delete(String api, String id) async {
    var url = Uri.parse(baseUrl + api + '/${id}');

    var response = await client.delete(url, body: {}, headers: _header);

    if (response.statusCode == 201 ||
        response.statusCode == 204 ||
        response.statusCode == 200) {
      return response.body;
    } else {
      return response.statusCode;
    }
  }
}
