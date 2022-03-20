// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

import '../data.dart';

class PortfolioDetailsScreen extends StatefulWidget {
  final Portfolio? portfolio;

  const PortfolioDetailsScreen({
    Key? key,
    this.portfolio,
  }) : super(key: key);

  @override
  _PortfolioDetailsScreen createState() => _PortfolioDetailsScreen();
}

class _PortfolioDetailsScreen extends State<PortfolioDetailsScreen> {
  bool _isEditing = false;
  
  void _handleTap() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }
  Widget showDetails() {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.portfolio!.title),
        actions: [
          IconButton(
            onPressed: _handleTap,
            icon: Icon(
              Icons.edit,
              color: Colors.white,
              size: 30.0,
            ),
          ),
          IconButton(
            onPressed: _handleTap,
            icon: Icon(
              Icons.delete,
              color: Colors.white,
              size: 30.0,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              widget.portfolio!.title,
              style: Theme.of(context).textTheme.headline4,
            ),
            Image.network(widget.portfolio!.imageUrl),
            Text(
              widget.portfolio!.imageAlt,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Text(
              widget.portfolio!.summary,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Text(
              widget.portfolio!.url,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            TextButton(
              child: const Text('View portfolio (Push)'),
              onPressed: () {
                Navigator.of(context).push<void>(
                  MaterialPageRoute<void>(
                    builder: (context) =>
                        PortfolioDetailsScreen(portfolio: widget.portfolio),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget showEdit() {

    final _titleController = TextEditingController(text: widget.portfolio!.title);
    final _imageAltController = TextEditingController(text: widget.portfolio!.imageUrl);
    final _imageUrlController = TextEditingController(text: widget.portfolio!.imageAlt);
    final _summaryController = TextEditingController(text: widget.portfolio!.summary);
    final _urlController = TextEditingController(text: widget.portfolio!.url);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.portfolio!.title),
        actions: [
          IconButton(
            onPressed: _handleTap,
            icon: Icon(
              Icons.check,
              color: Colors.white,
              size: 30.0,
            ),
          ),
          IconButton(
            onPressed: _handleTap,
            icon: Icon(
              Icons.highlight_off,
              color: Colors.white,
              size: 30.0,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Image'),
              controller: _imageUrlController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Image description'),
              controller: _imageAltController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Summary'),
              controller: _summaryController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Url'),
              controller: _urlController,
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    if (widget.portfolio == null) {
      return const Scaffold(
        body: Center(
          child: Text('No portfolio found.'),
        ),
      );
    }
    return !_isEditing ?  showDetails() : showEdit(); 
  }
}
