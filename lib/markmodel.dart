import 'dart:io';
import 'package:scoped_model/scoped_model.dart';

class MarkModel extends Model {
  File _markdownFile;
  String fileTxt = "";

  MarkModel(this._markdownFile);

  void readFile() {
    fileTxt = _markdownFile.readAsStringSync();
  }

  String get text => fileTxt;

  set text(String str) {
    fileTxt = str;
    _markdownFile.writeAsString(fileTxt);
    notifyListeners();
  }
}
