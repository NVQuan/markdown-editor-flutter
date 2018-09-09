import 'package:flutter/material.dart';
import 'package:markmemo/markmodel.dart';
import 'package:markmemo/markinput.dart';
import 'package:markmemo/markpreview.dart';
import 'package:scoped_model/scoped_model.dart';


class MarkMemo extends StatelessWidget {
  final MarkModel _model;

  MarkMemo(this._model);

  @override
  Widget build(BuildContext context) {
    
    return new ScopedModel<MarkModel>(
      model: _model,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new MarkInput()
          ),
          new MarkPreview(),
        ],
      )
    );
  }
}
