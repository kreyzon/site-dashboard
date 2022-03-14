// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:web/src/api.dart';

class SignIn {
  bool logged = false;
  String token = "";
}

/// A mock authentication service
class DashboardAuth extends ChangeNotifier {
  SignIn data = new SignIn();

  bool get signedIn => data.logged;

  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    // Sign out.
    data.logged = false;
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
      data.token = body['token'];
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