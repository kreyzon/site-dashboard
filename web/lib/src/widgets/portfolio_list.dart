// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../data.dart';

class PortfolioList extends StatelessWidget {
  final List<Portfolio> portfolios;
  final ValueChanged<Portfolio>? onTap;

  const PortfolioList({
    required this.portfolios,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: portfolios.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            portfolios[index].title,
          ),
          subtitle: Text(
            portfolios[index].summary,
          ),
          onTap: onTap != null ? () => onTap!(portfolios[index]) : null,
        ),
      );
}
