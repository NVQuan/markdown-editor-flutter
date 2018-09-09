import 'package:flutter/material.dart';
import 'package:markmemo/markmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class MarkInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new TextField(
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Please enter a search term'),
      keyboardType: TextInputType.multiline,
      maxLines: null,
      onChanged: (String txt) {
        ScopedModel.of<MarkModel>(context, rebuildOnChange: true).text = txt;
      }, 
    );
  }
}
