// Copyright 2021, the Flutter project portfolios. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:web/src/data/blog.dart';

import '../routing.dart';
import '../widgets/portfolio_list.dart';

class PortfoliosScreen extends StatelessWidget {
  final String title = 'Portfolio';

  const PortfoliosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: PortfolioList(
          portfolios: blogInstance.allPortfolios,
          onTap: (portfolio) {
            RouteStateScope.of(context).go('/portfolio/${portfolio.id}');
          },
        ),
      );
}
