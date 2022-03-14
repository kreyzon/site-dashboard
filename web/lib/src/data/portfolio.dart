// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class Portfolio {
  final int id;
  final String title;
  final String summary;
  final String url;
  final String imageUrl;
  final String imageAlt;

  Portfolio({required this.id, required this.title, required this.summary, required this.url, required this.imageUrl, required this.imageAlt});
  
  factory Portfolio.fromJson(Map<String, dynamic> json) {
    return Portfolio(
      id: json['Id'],
      title: json['Title'],
      summary: json['Summary'],
      url: json['Url'],
      imageUrl: json['ImageUrl'],
      imageAlt: json['ImageAlt'],
    );
  }
}
