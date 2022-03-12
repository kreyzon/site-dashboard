// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:web/src/widgets/post_list.dart';

import '../data.dart';
import '../routing.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(_handleTabIndexChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final newPath = _routeState.route.pathTemplate;
    if (newPath.startsWith('/posts/popular')) {
      _tabController.index = 0;
    } else if (newPath.startsWith('/posts/new')) {
      _tabController.index = 1;
    } else if (newPath == '/posts/all') {
      _tabController.index = 2;
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndexChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Posts'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                text: 'Popular',
                icon: Icon(Icons.people),
              ),
              Tab(
                text: 'New',
                icon: Icon(Icons.new_releases),
              ),
              Tab(
                text: 'All',
                icon: Icon(Icons.list),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            PostList(
              posts: blogInstance.popularPosts,
              onTap: _handlePortfolioTapped,
            ),
            PostList(
              posts: blogInstance.newPosts,
              onTap: _handlePortfolioTapped,
            ),
            PostList(
              posts: blogInstance.allPosts,
              onTap: _handlePortfolioTapped,
            ),
          ],
        ),
      );

  RouteState get _routeState => RouteStateScope.of(context);

  void _handlePortfolioTapped(Post post) {
    _routeState.go('/post/${post.id}');
  }

  void _handleTabIndexChanged() {
    switch (_tabController.index) {
      case 1:
        _routeState.go('/posts/new');
        break;
      case 2:
        _routeState.go('/posts/all');
        break;
      case 0:
      default:
        _routeState.go('/posts/popular');
        break;
    }
  }
}
