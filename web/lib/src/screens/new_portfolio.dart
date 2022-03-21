
import 'package:flutter/material.dart';
import 'package:web/src/api.dart';
import 'package:web/src/auth.dart';
import 'package:web/src/data.dart';

class PortfolioNewScreen extends StatefulWidget {

  const PortfolioNewScreen({
    Key? key,
  }) : super(key: key);

  @override
  _PortfolioNewScreen createState() => _PortfolioNewScreen();
}

class _PortfolioNewScreen extends State<PortfolioNewScreen> {
  Portfolio? portfolio;

  void _handleCreatePortfolio() async {
    // TODO: show success toastr and back to list
  }

  void _handleCancel() async {
    // TODO: back to list
  }

  @override
  Widget build(BuildContext context) {
    final _titleController = TextEditingController();
    final _imageAltController = TextEditingController();
    final _imageUrlController = TextEditingController();
    final _summaryController = TextEditingController();
    final _urlController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("New Portfolio"),
        actions: [
          IconButton(
            onPressed: () async {
              try {
              String? token = await storage.read(key: "jwt");
              final response = await new ApiHandler().post(
                    "/portfolio-admin",
                    {
                      "title": _titleController.value.text,
                      "imageAlt": _imageAltController.value.text,
                      "imageUrl": _imageUrlController.value.text,
                      "summary": _summaryController.value.text,
                      "url": _urlController.value.text,
                    },
                    token: token!);
                if (response != "") {
                  _handleCreatePortfolio();
                }
              } catch (e) {
                // TODO: show error
              }
            },
            icon: Icon(
              Icons.check,
              color: Colors.white,
              size: 30.0,
            ),
          ),
          IconButton(
            onPressed: _handleCancel,
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
}