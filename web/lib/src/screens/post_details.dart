// Copyright 2021, the Flutter project posts. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../data.dart';
import '../routing.dart';
import '../widgets/portfolio_list.dart';

class PostDetailsScreen extends StatelessWidget {
  final Post post;

  const PostDetailsScreen({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(post.title),
        ),
        body: Center(
          child: Column(
            children: [
              // Expanded(
              //   child: PostList(
              //     posts: post.posts,
              //     onTap: (post) {
              //       RouteStateScope.of(context).go('/post/${post.id}');
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      );
}
