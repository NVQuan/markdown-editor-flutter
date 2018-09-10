import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:markmemo/markmemo.dart';
import 'package:markmemo/markmodel.dart';

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
  File file;
  FileListItem(this.file);
  
  String get filePath => file.path.replaceAll(new RegExp('.+/'), '');
}

class MemoFileList extends StatefulWidget {
  final CounterStorage storage;

  MemoFileList({Key key, @required this.storage}) : super(key: key);

  @override
  _MemoFileListState createState() => _MemoFileListState();
}

class FileNameUtil {
  String getUniqueFileName(String before, List<FileListItem> items) {
    int newbefileCnt = items.where((item) => item.filePath.contains(before)).length;
    return newbefileCnt < 1 ? '$before.md' : '${before}_${newbefileCnt + 1}.md';
  }
}

enum _DialogActionType {
  cancel,
  ok,
}

class _MemoFileListState extends State<MemoFileList> {
  final TextEditingController dialogContoroller = TextEditingController();
  String _txt = '';
  String _title = '';
  List<FileListItem> _items;

  @override
  void initState() {
    super.initState();
    setTitle();
    readFiles();
    setState(() {
      _items.sort((item1, item2) {
        return item1.filePath.compareTo(item2.filePath);
      });
    });
  }

  Future<void> setTitle() async {
    _title = await widget.storage._localPath;
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
    String newFileName = FileNameUtil().getUniqueFileName("new_markdown_file", _items);
    File newFile = await widget.storage.createFile(newFileName);
    newFile.writeAsStringSync("# created by flutter app.");
    setState(() {
      _items.add(FileListItem(newFile));
      _items.sort((item1, item2) {
        return item1.filePath.compareTo(item2.filePath);
      });
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
      appBar: AppBar(title: Text(_title)),
      body: new ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          if (index < _items.length) {
            var item = _items[index];
            return GestureDetector(
              onTap: () => navigateToFile(context, item),
              onLongPress: () {
                dialogContoroller.text = item.filePath;
                showDialog<_DialogActionType>(
                    context: context,
                    builder: (BuildContext context) => new AlertDialog(
                      title: Text("Rename File..."),
                      content: TextField(
                        controller: dialogContoroller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'input new filename...'
                        ),
                        onChanged: (String str) {
                          _txt = str;
                        },
                      ),
                      actions: [
                        FlatButton(
                          child: Text("cancel"),
                          onPressed: () => Navigator.pop(context, _DialogActionType.cancel)
                        ),
                        FlatButton(
                          child: Text("ok"),
                          onPressed: () => Navigator.pop(context, _DialogActionType.ok)
                        ),
                      ],
                    ),
                ).then<void>((_DialogActionType value) { // The value passed to Navigator.pop() or null.
                  switch(value) {
                    case _DialogActionType.cancel:
                      break;
                    case _DialogActionType.ok:
                      setState(() {
                        String name = FileNameUtil().getUniqueFileName(_txt, _items);
                        _items.removeAt(index);
                        widget.storage._localPath.then((path) => 
                          _items.add(FileListItem(item.file.renameSync('$path/$name'))));
                        _items.sort((item1, item2) {
                          return item1.filePath.compareTo(item2.filePath);
                        });
                      });
                      break;
                    default:
                  }
                });
              },
              child: new SizedBox(
                height: 64.0,
                child: new Card(
                  child: new Container(
                    alignment: Alignment.centerLeft,
                    child: Text("${item.filePath}", style: TextStyle(fontSize: 20.0),)
                  ),
                ),
              )
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
