import 'package:flutter/material.dart';
import 'package:markmemo/filelist.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Markmemo with Flutter',
      home: Center(
        // child: Text('Hello World'),
        child: MemoFileList(storage: CounterStorage()),
      ),
    );
  }
}

