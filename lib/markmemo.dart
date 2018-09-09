import 'package:flutter/material.dart';
import 'package:markmemo/markmodel.dart';
import 'package:markmemo/markinput.dart';
import 'package:markmemo/markpreview.dart';
import 'package:markmemo/htmlpreview.dart';
import 'package:scoped_model/scoped_model.dart';

class MarkMemo extends StatelessWidget {
  final MarkModel model;
  final String title;

  MarkMemo({Key key, this.model, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ScopedModel<MarkModel>(
        model: model,
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: TabBarView(
              children: [
                Container(child: 
                  MarkInput()
                ),
                Container(child:
                  MarkPreview()
                ),
                Container(child:
                  HtmlPreview()
                ),
              ],
            ),
            bottomNavigationBar: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.edit),
                  text: 'input',
                ),
                Tab(
                  icon: Icon(Icons.subject),
                  text: 'markdown preview',
                ),
                Tab(
                  icon: Icon(Icons.language),
                  text: 'html preview',
                ),
              ],
              labelColor: Colors.deepOrange,
              unselectedLabelColor: Colors.blue,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.all(5.0),
              indicatorColor: Colors.red,
            ),
          ),
        ));
  }
}
