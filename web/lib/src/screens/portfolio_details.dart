// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

import '../data.dart';

class PortfolioDetailsScreen extends StatelessWidget {
  final Portfolio? portfolio;

  const PortfolioDetailsScreen({
    Key? key,
    this.portfolio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (portfolio == null) {
      return const Scaffold(
        body: Center(
          child: Text('No portfolio found.'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(portfolio!.title),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              portfolio!.title,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              portfolio!.title,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            TextButton(
              child: const Text('View portfolio (Push)'),
              onPressed: () {
                Navigator.of(context).push<void>(
                  MaterialPageRoute<void>(
                    builder: (context) =>
                        PortfolioDetailsScreen(portfolio: portfolio),
                  ),
                );
              },
            ),
            Link(
              uri: Uri.parse('/portfolio/${portfolio!.id}'),
              builder: (context, followLink) => TextButton(
                onPressed: followLink,
                child: const Text('View portfolio (Link)'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
