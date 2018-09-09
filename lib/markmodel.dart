import 'package:scoped_model/scoped_model.dart';

class MarkModel extends Model {
  String _markText = "# Edit Markdown...";

  String get text => _markText;

  set text(String str) {
    _markText = str;
    //状態を変更したらnotifyListenersを呼ぶ。
    notifyListeners();
  }
}
