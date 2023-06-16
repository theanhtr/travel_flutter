import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String baseUrl =
    "https://82bb-2405-4802-1c94-5f90-5156-cdcc-972f-fabb.ngrok-free.app/api";

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
    // print("header day: ${_header}");
    // print("header day:  ${url}");
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

  Future<dynamic> postRoleId(
      String api, dynamic object, dynamic object1) async {
    var url = Uri.parse(baseUrl + api);
    var payload = json.encode({'email': object, 'role_id': object1});

    var response = await client.patch(url, body: payload, headers: _header);
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

  Future<dynamic> postNewUser(
      String api, dynamic object, dynamic object1) async {
    var url = Uri.parse(baseUrl + api);
    var payload = json.encode({'email': object, 'role_id': object1});

    var response = await client.post(url, body: payload, headers: _header);
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

  Future<dynamic> delete(String api, String id) async {
    var _headerDelete = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $tokenAuth',
    };
    var url = Uri.parse(baseUrl + api + '/${id}');

    var response = await client.delete(url, body: {}, headers: _headerDelete);

    if (response.statusCode == 201 ||
        response.statusCode == 204 ||
        response.statusCode == 200) {
      return response.body;
    } else {
      return response.statusCode;
    }
  }

  Future<dynamic> deleteWithOneParameter(String api) async {
    var _headerDelete = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $tokenAuth',
    };
    var url = Uri.parse(baseUrl + api);

    var response = await client.delete(url, body: {}, headers: _headerDelete);

    if (response.statusCode == 201 ||
        response.statusCode == 204 ||
        response.statusCode == 200) {
      return response.body;
    } else {
      return response.statusCode;
    }
  }

  Future<dynamic> deleteWithBody(String api, Object body) async {
    var _headerDelete = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $tokenAuth',
    };
    var url = Uri.parse(baseUrl + api);

    var response = await client.delete(url, body: body, headers: _headerDelete);

    if (response.statusCode == 201 ||
        response.statusCode == 204 ||
        response.statusCode == 200) {
      return response.body;
    } else {
      return response.statusCode;
    }
  }

  Future<dynamic> deleteMyhotel(
    String api,
  ) async {
    var url = Uri.parse(baseUrl + api);

    var response = await client.delete(url, body: {}, headers: _header);

    if (response.statusCode == 201 ||
        response.statusCode == 204 ||
        response.statusCode == 200) {
      return response.body;
    } else {
      return response.statusCode;
    }
  }

  Future<dynamic> deleteUser(String api, String email) async {
    var _headerDelete = {
      'Accept': 'application/json',
      // 'Content-Type': 'application/json',
      'Authorization': 'Bearer $tokenAuth',
    };
    print(_headerDelete);
    var url = Uri.parse(baseUrl + api);
    var body = jsonEncode({"email": email});

    final Object;
    Object = {'email': 'email'};
    print(jsonEncode(Object));
    var response = await client.delete(url,
        body: {"email": email}, headers: _headerDelete);

    if (response.statusCode == 201 ||
        response.statusCode == 204 ||
        response.statusCode == 200) {
      return response.body;
    } else {
      print(response.body);
      return response.statusCode;
    }
  }

  Future<dynamic> deleteAmenities(String api, String amenities) async {
    var _headerDelete = {
      'Accept': 'application/json',
      // 'Content-Type': 'application/json',
      'Authorization': 'Bearer $tokenAuth',
    };
    print("amnities: $amenities");
    var url = Uri.parse(baseUrl + api);
    var body = jsonEncode({"amenities": amenities});

    final Object;
    Object = {'amenities': 'amenities'};
    print(jsonEncode(Object));
    var response = await client.delete(url,
        body: {"amenities": amenities}, headers: _headerDelete);

    if (response.statusCode == 201 ||
        response.statusCode == 204 ||
        response.statusCode == 200) {
      return response.body;
    } else {
      print(response.body);
      return response.statusCode;
    }
  }

  Future<dynamic> deleteHotelIamge(String api, String images_id) async {
    var _headerDelete = {
      'Accept': 'application/json',
      // 'Content-Type': 'application/json',
      'Authorization': 'Bearer $tokenAuth',
    };
    print("images_id: $images_id");
    var url = Uri.parse(baseUrl + api);
    var body = jsonEncode({"images_id": images_id});

    final Object;
    Object = {'images_id': 'images_id'};
    print(jsonEncode(Object));
    var response = await client.delete(url,
        body: {"images_id": images_id}, headers: _headerDelete);

    if (response.statusCode == 201 ||
        response.statusCode == 204 ||
        response.statusCode == 200) {
      return response.body;
    } else {
      print(response.body);
      return response.statusCode;
    }
  }
}
