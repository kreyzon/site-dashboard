// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:web/src/api.dart';

class SignIn {
  bool logged = false;
}
final FlutterSecureStorage storage = new FlutterSecureStorage();

/// A mock authentication service
class DashboardAuth extends ChangeNotifier {
  SignIn data = new SignIn();

  bool get signedIn => data.logged;

  Future<void> checkToken() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    try {
    String? token = await storage.read(key: "jwt");
    final response = await new ApiHandler().post(
          "/auth/me",
          {},
          token: token!);
      if (response != "") {
        data.logged = true;
      }
    } catch (e) {
      await storage.delete(key: "jwt");
      data.logged = false;
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    // Sign out.
    data.logged = false;
    await storage.delete(key: "jwt");
    notifyListeners();
  }

  Future<SignIn> signIn(String username, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    // Sign in. Allow any password.
    try {
      final response = await new ApiHandler().post(
          "/auth/login",
          {
            'username': username,
            'password': password,
          });
      Map<String, dynamic> body = jsonDecode(response);
      data.logged = true;
      await storage.write(key: "jwt", value: body['token']);
      notifyListeners();
      return data;
    } catch (e) {
      throw Exception('Failed to login: '+e.toString());
    }
  }

  @override
  bool operator ==(Object other) =>
      other is DashboardAuth && other.data.logged == data.logged;

  @override
  int get hashCode => data.logged.hashCode;
}

class DashboardAuthScope extends InheritedNotifier<DashboardAuth> {
  const DashboardAuthScope({
    required DashboardAuth notifier,
    required Widget child,
    Key? key,
  }) : super(key: key, notifier: notifier, child: child);

  static DashboardAuth of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<DashboardAuthScope>()!
      .notifier!;
}