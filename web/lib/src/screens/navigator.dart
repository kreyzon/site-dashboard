// Copyright 2021, the Flutter project posts. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../auth.dart';
import '../data.dart';
import '../routing.dart';
import '../screens/sign_in.dart';
import '../widgets/fade_transition_page.dart';
import 'post_details.dart';
import 'portfolio_details.dart';
import 'scaffold.dart';

/// Builds the top-level navigator for the app. The pages to display are based
/// on the `routeState` that was parsed by the TemplateRouteParser.
class DashboardNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const DashboardNavigator({
    required this.navigatorKey,
    Key? key,
  }) : super(key: key);

  @override
  _DashboardNavigatorState createState() => _DashboardNavigatorState();
}

class _DashboardNavigatorState extends State<DashboardNavigator> {
  final _signInKey = const ValueKey('Sign in');
  final _scaffoldKey = const ValueKey('App scaffold');
  final _portfolioDetailsKey = const ValueKey('Portfolio details screen');
  final _postDetailsKey = const ValueKey('Post details screen');

  @override
  Widget build(BuildContext context) {
    final routeState = RouteStateScope.of(context);
    final authState = DashboardAuthScope.of(context);
    final pathTemplate = routeState.route.pathTemplate;

    Portfolio? selectedPortfolio;
    if (pathTemplate == '/portfolio/:portfolioId') {
      selectedPortfolio = blogInstance.allPortfolios.firstWhereOrNull(
          (b) => b.id.toString() == routeState.route.parameters['portfolioId']);
    }

    Post? selectedPost;
    if (pathTemplate == '/post/:postId') {
      selectedPost = blogInstance.allPosts.firstWhereOrNull(
          (b) => b.id.toString() == routeState.route.parameters['postId']);
    }

    return Navigator(
      key: widget.navigatorKey,
      onPopPage: (route, dynamic result) {
        // When a page that is stacked on top of the scaffold is popped, display
        // the /portfolios or /posts tab in DashboardScaffold.
        if (route.settings is Page &&
            (route.settings as Page).key == _portfolioDetailsKey) {
          routeState.go('/portfolios');
        }

        if (route.settings is Page &&
            (route.settings as Page).key == _postDetailsKey) {
          routeState.go('/posts/popular');
        }

        return route.didPop(result);
      },
      pages: [
        if (routeState.route.pathTemplate == '/signin')
          // Display the sign in screen.
          FadeTransitionPage<void>(
            key: _signInKey,
            child: SignInScreen(
              onSignIn: (credentials) async {
                var signedIn = await authState.signIn(
                    credentials.username, credentials.password);
                if (signedIn.logged) {
                  routeState.go('/posts/popular');
                }
              },
            ),
          )
        else ...[
          // Display the app
          FadeTransitionPage<void>(
            key: _scaffoldKey,
            child: const DashboardScaffold(),
          ),
          // Add an additional page to the stack if the user is viewing a portfolio
          // or an post
          if (selectedPortfolio != null)
            MaterialPage<void>(
              key: _portfolioDetailsKey,
              child: PortfolioDetailsScreen(
                portfolio: selectedPortfolio,
              ),
            )
          else if (selectedPost != null)
            MaterialPage<void>(
              key: _postDetailsKey,
              child: PostDetailsScreen(
                post: selectedPost,
              ),
            ),
        ],
      ],
    );
  }
}
