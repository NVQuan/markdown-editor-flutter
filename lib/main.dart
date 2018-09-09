import 'package:flutter/material.dart';
import 'package:markmemo/markmodel.dart';
import 'package:markmemo/markmemo.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
          // child: Text('Hello World'),
          child: new MarkMemo(MarkModel()),
        ),
      ),
    );
  }
}

