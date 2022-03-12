// Copyright 2021, the Flutter project posts. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../data.dart';

class PostList extends StatelessWidget {
  final List<Post> posts;
  final ValueChanged<Post>? onTap;

  const PostList({
    required this.posts,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            posts[index].title,
          ),
          subtitle: Text(
            'Add some info here',
          ),
          onTap: onTap != null ? () => onTap!(posts[index]) : null,
        ),
      );
}
