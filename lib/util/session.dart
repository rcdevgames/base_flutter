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

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import '../models/user_model.dart';
// import '../models/auth_model.dart';

class Sessions {
  final storage = new FlutterSecureStorage();

  Future<bool> checkAuth() async {
    var token = await storage.read(key: "token");
    var user = await storage.read(key: "auth");
    if (token != null && user != null) return true;
    return false;
  }

  Future save(String key, String data) async {
    return storage.write(key: key, value: data);
  }

  Future clear() async {
    return storage.deleteAll();
  }

  Future<String> load(String key) async {
    return storage.read(key: key);
  }

  remove(String key) async {
    return storage.delete(key: key);
  }

  // Future<User> loadUser() async {
  //   final user = await storage.read(key: "auth");
  //   return user == null ? null : compute(userFromJson, user);
  // }

  // Future<Auth> loadAuth() async {
  //   final auth = await storage.read(key: "token");
  //   return auth == null ? null : compute(authFromJson, auth);
  // }

}

final sessions = new Sessions();
