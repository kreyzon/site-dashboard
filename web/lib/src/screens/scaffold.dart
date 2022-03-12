// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';

import '../routing.dart';
import 'scaffold_body.dart';

class DashboardScaffold extends StatelessWidget {
  const DashboardScaffold({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeState = RouteStateScope.of(context);
    final selectedIndex = _getSelectedIndex(routeState.route.pathTemplate);

    return Scaffold(
      body: AdaptiveNavigationScaffold(
        selectedIndex: selectedIndex,
        body: const DashboardScaffoldBody(),
        onDestinationSelected: (idx) {
          if (idx == 0) routeState.go('/posts/popular');
          if (idx == 1) routeState.go('/portfolios');
          if (idx == 2) routeState.go('/settings');
        },
        destinations: const [
          AdaptiveScaffoldDestination(
            title: 'Posts',
            icon: Icons.book,
          ),
          AdaptiveScaffoldDestination(
            title: 'Portfolio',
            icon: Icons.person,
          ),
          AdaptiveScaffoldDestination(
            title: 'Settings',
            icon: Icons.settings,
          ),
        ],
      ),
    );
  }

  int _getSelectedIndex(String pathTemplate) {
    if (pathTemplate.startsWith('/posts')) return 0;
    if (pathTemplate == '/portfolios') return 1;
    if (pathTemplate == '/settings') return 2;
    return 0;
  }
}
