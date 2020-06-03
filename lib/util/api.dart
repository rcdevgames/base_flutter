/*
 * MIT License
 *
 * Copyright (c) 2020 Rizky Andhika Putra
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import 'dart:convert';
import 'session.dart';
import 'package:http/http.dart' show Client, Response;

const API_URL = "http://139.180.210.169:5001/api/v1";

class Api {
  Client client = new Client();
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  Future<Response> get(String endpoint, {bool auth = false}) async {
    // var token = await sessions.loadAuth();
    // if (auth && token != null) requestHeaders['Authorization'] = "Bearer ${token?.accessToken}";
    return client.get("$API_URL$endpoint", headers: requestHeaders);
  }

  Future<Response> post(String endpoint,
      {bool auth = false, Map<String, dynamic> body, String token}) async {
    if (auth && token != null) {
      // token = token ?? (await sessions.loadAuth())?.accessToken;
      requestHeaders['Authorization'] = "Bearer ${token}";
    }
    return client.post("$API_URL$endpoint",
        headers: requestHeaders, body: jsonEncode(body));
  }

  Future<Response> put(String endpoint,
      {bool auth = false, Map<String, dynamic> body}) async {
    // var token = await sessions.loadAuth();
    // if (auth && token != null) requestHeaders['Authorization'] = "Bearer ${token?.accessToken}";
    return client.put("$API_URL$endpoint",
        headers: requestHeaders, body: jsonEncode(body));
  }

  Future<Response> delete(String endpoint, {bool auth = false}) async {
    // var token = await sessions.loadAuth();
    // if (auth && token != null) requestHeaders['Authorization'] = "Bearer ${token?.accessToken}";
    print("$API_URL$endpoint");
    return client.delete("$API_URL$endpoint", headers: requestHeaders);
  }

  String image_url(String filename) {
    return "$API_URL/cdn/image/$filename";
  }

  void cancel() {
    client?.close();
    client = new Client();
  }

  String getMessage(String data) {
    var result = jsonDecode(data)['message'];
    return result.runtimeType == String ? result : jsonEncode(result);
  }

  String getError(String error) {
    Map<String, dynamic> result = jsonDecode(error)['errors'];
    if (result != null || result != {}) {
      return result.values.toList()[0][0];
    }
  }

  String getData(String data) {
    Map<String, dynamic> dataMap = jsonDecode(data);
    if (dataMap.containsKey("data")) {
      return jsonEncode(dataMap["data"]);
    }
    return null;
  }
}

final api = new Api();
