import 'package:flutter/material.dart';
import 'package:markmemo/markmodel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:markdown/markdown.dart';

class HtmlPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
      // child: new HtmlView(data: markdownToHtml(_markText, extensionSet: ExtensionSet.gitHubWeb)),
      child: new HtmlView(data: markdownToHtml(ScopedModel.of<MarkModel>(context, rebuildOnChange: true).text, extensionSet: ExtensionSet.gitHubWeb)),
    );
  }
}
