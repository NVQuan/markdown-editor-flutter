import 'package:flutter/material.dart';
import 'package:markmemo/markmodel.dart';
import 'package:markmemo/markmemo.dart';
import 'package:markmemo/filelist.dart';

void main() => runApp(new FileApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Markmemo with Flutter',
      home: Center(
        // child: Text('Hello World'),
        child: new MarkMemo(model: MarkModel(null), title: 'Title!!!!!!'),
      ),
    );
  }
}

