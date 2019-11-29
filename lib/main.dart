// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(primarySwatch: Colors.green),
      home: RandomWords(),
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text('Welcome to Flutter'),
//        ),
//        body: Center(
//          child: RandomWords(),
//        ),
//      ),
    );
  }
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _contentFont = const TextStyle(fontSize: 14.0);
  var position = 0;
  var longPosition = 0;

  @override
  Widget build(BuildContext context) {
//    final wordPair = WordPair.random();
//    return Text(wordPair.asPascalCase);

    return Scaffold(
      appBar: AppBar(
        title: Text('Startup [click:$position] [longClick:$longPosition]'),
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider();
          /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(index, _suggestions[index]);
        });
  }

  Widget _buildRow(int index, WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      subtitle: Text(
        pair.asCamelCase + "<=驼峰",
        style: _contentFont,
      ),
      onTap: () {
        setState(() {
          position = index;
        });
        print("onTap position: $index");
      },
      onLongPress: () {
        setState(() {
          longPosition = index;
        });
        print("onLongPress position: $index, ${pair.first}");
      },
    );
  }
}

// a stateful widget
class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RandomWordsState();
}

// 第四步：创建一个无限滚动的 ListView
