// Copyright 2021, the Flutter project portfolios. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web/src/api.dart';
import 'package:web/src/data.dart';

import '../routing.dart';
import '../widgets/portfolio_list.dart';

Future<List<Portfolio>> fetchPortfolios() async {
  final response = await new ApiHandler().get("/portfolio");
  List<dynamic> body = jsonDecode(response);
  List<Portfolio> result = body.map((element) => Portfolio.fromJson(element)).toList();
  blogInstance.allPortfolios.addAll(result);
  return result;
}
class PortfoliosScreen extends StatefulWidget {
  const PortfoliosScreen({Key? key}) : super(key: key);

  @override
  _PortfoliosScreen createState() => _PortfoliosScreen();
}

class _PortfoliosScreen extends State<PortfoliosScreen> {
  final String title = 'Portfolio';
  late Future<List<Portfolio>> futurePortfolios;

  @override
  void initState() {
    super.initState();
    futurePortfolios = fetchPortfolios();
  }
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body:  FutureBuilder<List<Portfolio>>(
            future: futurePortfolios,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PortfolioList(
                  portfolios: snapshot.data!,
                  onTap: (portfolio) {
                    RouteStateScope.of(context).go('/portfolio/${portfolio.id}');
                  });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            }
        ),
      );
}
