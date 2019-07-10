import 'package:flutter/material.dart';

import 'package:moving/ui/searchpage.dart';
import './ui/mainpage.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData.dark(),
      home: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie App'),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 15),
            child: IconButton(
                icon: Icon(Icons.search),
                iconSize: 30,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => searchpage()));
                }),
          )
        ],
      ),
      body: mainPage(),
    );
  }
}
