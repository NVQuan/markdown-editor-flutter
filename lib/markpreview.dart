import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markmemo/markmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class MarkPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Markdown(
      data: ScopedModel.of<MarkModel>(context, rebuildOnChange: true).text
    );
  }
}
