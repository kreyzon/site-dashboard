// Copyright 2021, the Flutter project posts. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'post.dart';
import 'portfolio.dart';

final blogInstance = Blog()
  ..addPost(
      title: 'Left Hand of Darkness',
      postName: 'Ursula K. Le Guin',
      isPopular: true,
      isNew: true)
  ..addPost(
      title: 'Too Like the Lightning',
      postName: 'Ada Palmer',
      isPopular: false,
      isNew: true)
  ..addPost(
      title: 'Kindred',
      postName: 'Octavia E. Butler',
      isPopular: true,
      isNew: false)
  ..addPost(
      title: 'The Lathe of Heaven',
      postName: 'Ursula K. Le Guin',
      isPopular: false,
      isNew: false);

class Blog {
  final List<Portfolio> allPortfolios = [];
  final List<Post> allPosts = [];

  void addPost({
    required String title,
    required String postName,
    required bool isPopular,
    required bool isNew,
  }) {
    allPosts.firstWhere(
      (post) => post.title == title,
      orElse: () {
        final value = Post(allPosts.length, title, postName, isNew, isPopular);
        allPosts.add(value);
        return value;
      },
    );
    // TODO: add logic to get all Portfolios from database
    // var portfolio = Portfolio(allPortfolios.length, title, isPopular, isNew, post);
    // allPortfolios.add(portfolio);
  }

  List<Post> get popularPosts => [
        ...allPosts.where((post) => post.isPopular),
      ];

  List<Post> get newPosts => [
        ...allPosts.where((post) => post.isNew),
      ];
}
