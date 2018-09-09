import 'package:flutter/material.dart';
import 'markmodel.dart';
import 'markmemo.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(new MyApp(MarkModel()));

class MyApp extends StatelessWidget {
  final MarkModel model;

  MyApp(this.model);

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
          child: ScopedModel<MarkModel>(
            model: model,
            child: new RandomWords()
          ),
        ),
      ),
    );
  }
}

