import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiHandler {
  static Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': '*'
  };
  static const String baseURL = String.fromEnvironment("API_URL",
      defaultValue: "http://localhost:8080/v1");
  var statusOK = [200, 201, 204];

  Future<String> get(String path, {String token = ''}) async {
    if (token != '') {
      var authEntry = <String, String>{'Authorization': 'Bearer ' + token};
      defaultHeaders.addEntries(authEntry.entries);
    }
    final response = await http.get(
      Uri.parse(baseURL + path),
      headers: defaultHeaders,
    );
    if (!statusOK.contains(response.statusCode)) {
      if (response.statusCode == 401) {
        defaultHeaders.remove('Authorization');
      }
      throw Exception(['Error in request', response.statusCode, response.body]);
    }
    return response.body;
  }

  Future<String> post(String path, Object body, {String token = ''}) async {
    if (token != '') {
      var authEntry = <String, String>{'Authorization': 'Bearer ' + token};
      defaultHeaders.addEntries(authEntry.entries);
    }
    final response = await http.post(
      Uri.parse(baseURL + path),
      headers: defaultHeaders,
      body: jsonEncode(body),
    );
    if (!statusOK.contains(response.statusCode)) {
      if (response.statusCode == 401) {
        defaultHeaders.remove('Authorization');
      }
      throw Exception(['Error in request', response.statusCode, response.body]);
    }
    return response.body;
  }

  Future<String> put(String path, Object body, {String token = ''}) async {
    if (token != '') {
      var authEntry = <String, String>{'Authorization': 'Bearer ' + token};
      defaultHeaders.addEntries(authEntry.entries);
    }
    final response = await http.put(
      Uri.parse(baseURL + path),
      headers: defaultHeaders,
      body: jsonEncode(body),
    );
    if (!statusOK.contains(response.statusCode)) {
      if (response.statusCode == 401) {
        defaultHeaders.remove('Authorization');
      }
      throw Exception(['Error in request', response.statusCode, response.body]);
    }
    return response.body;
  }

  Future<String> delete(String path, Object body, {String token = ''}) async {
    if (token != '') {
      var authEntry = <String, String>{'Authorization': 'Bearer ' + token};
      defaultHeaders.addEntries(authEntry.entries);
    }
    final response = await http.delete(
      Uri.parse(baseURL + path),
      headers: defaultHeaders,
      body: jsonEncode(body),
    );
    if (!statusOK.contains(response.statusCode)) {
      if (response.statusCode == 401) {
        defaultHeaders.remove('Authorization');
      }
      throw Exception(['Error in request', response.statusCode, response.body]);
    }
    return response.body;
  }
}
