import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:markdown/markdown.dart';

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _markdownCtr = TextEditingController();
  var _markText = "";

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _markdownCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return new Row(
      children: <Widget>[
        new Expanded(
          child: new TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Please enter a search term'),
            controller: _markdownCtr,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            onChanged: (String e) {
              setState(() {
                _markText = e;
              });
            },
          ),
        ),
        new SingleChildScrollView(
          // child: new HtmlView(data: markdownToHtml(_markText, extensionSet: ExtensionSet.gitHubWeb)),
          child: new HtmlView(data: markdownToHtml(_markText, extensionSet: ExtensionSet.gitHubWeb)),
        ),
      ],
    );
  }
}
