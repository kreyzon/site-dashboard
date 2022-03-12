// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class Post {
  final int id;
  final String title;
  final String content;
  final bool isPopular;
  final bool isNew;

  Post(this.id, this.title, this.content, this.isNew, this.isPopular);
}
