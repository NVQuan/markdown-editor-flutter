import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:markmemo/markmemo.dart';
import 'package:markmemo/markmodel.dart';

class FileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Reading and Writing Files',
      home: FlutterDemo(storage: CounterStorage()),
    );
  }
}

class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<Stream<FileSystemEntity>> get _filelist async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.list(recursive: true);
  }

  Future<File> createFile(String name) async {
    final path = await _localPath;
    return File('$path/$name');
  }
}

class FileListItem {
  final File _file;
  FileListItem(this._file);
  File get file => _file;
  String get filePath => _file.path.replaceAll(new RegExp('.+/'), '');
}

class FlutterDemo extends StatefulWidget {
  final CounterStorage storage;

  FlutterDemo({Key key, @required this.storage}) : super(key: key);

  @override
  _FlutterDemoState createState() => _FlutterDemoState();
}

class _FlutterDemoState extends State<FlutterDemo> {
  List<FileListItem> _items;

  @override
  void initState() {
    super.initState();
    readFiles();
  }

  Future<void> readFiles() async {
    if (_items == null) {
      _items = <FileListItem>[];
    }
    var fileStream = await widget.storage._filelist;
    fileStream
      .where((entity) => entity is File && (entity.path.endsWith(".md") || entity.path.endsWith(".txt")))
      .map((file) => FileListItem(file))
      .forEach((FileListItem item) {
        setState(() {
          _items.add(item);
        });
      });
  }

  Future<void> createFile() async {
    int newbefileCnt = _items.where((item) => item.filePath.contains("new_markdown_file")).length;
    File newFile = await widget.storage.createFile("new_markdown_file${newbefileCnt + 1}.md");
    newFile.writeAsStringSync("# created by flutter app.");
    setState(() {
      _items.add(FileListItem(newFile));
    });
  }

  void navigateToFile(BuildContext context, FileListItem item) {
    MarkModel model = MarkModel(item.file);
    model.readFile();
    Navigator.push(context, new MaterialPageRoute(builder: (context) =>
      new MarkMemo(title: item.filePath, model: model,)
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MarkMemo with Flutter')),
      body: new ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          if (index < _items.length) {
            var item = _items[index];
            return GestureDetector(
              onTap: () => navigateToFile(context, item),
              child: new SizedBox(
                height: 64.0,
                child: new Card(
                  child: new Container(
                    alignment: Alignment.centerLeft,
                    child: Text("${item.filePath}", style: TextStyle(fontSize: 20.0),)
                  ),
                ),
              )
              // child: Container(
              //   decoration: BoxDecoration(
              //     border: Border(
              //       bottom: BorderSide(
              //         color: Colors.black12,
              //       )
              //     ),
              //   ),
              //   child: Text("${item.filePath}")
              // )
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createFile,
        tooltip: 'Add File',
        child: Icon(Icons.create),
      ),
    );
  }
}
