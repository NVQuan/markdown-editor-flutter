import 'package:flutter/material.dart';
import 'package:markmemo/markmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class MarkInputState extends State<MarkInput> {
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myController.addListener(_printLatestValue);
  }

  void _printLatestValue() {
    ScopedModel.of<MarkModel>(context, rebuildOnChange: false).text = myController.text;
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    myController.text = ScopedModel.of<MarkModel>(context, rebuildOnChange: false).text;
    return ListView(children: [
      Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black12,
            )
          ),
        ),
        child: TextField(
            controller: myController,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '# Edit Markdown...'),
            keyboardType: TextInputType.multiline,
            maxLines: null,
        ),
      ),
      Container(
        height: 48.0,
        child: new ListView(
          scrollDirection: Axis.horizontal,
          children: [
            MaterialButton(
              color: Colors.black12,
              child: Text('###'),
              onPressed: () {
                myController.text = myController.text.substring(0, myController.selection.start)
                  + '### '
                  + myController.text.substring(myController.selection.start);
              },
            ),
            MaterialButton(
              color: Colors.black12,
              child: Text('-'),
              onPressed: () {
                myController.text = myController.text.substring(0, myController.selection.start)
                  + '- '
                  + myController.text.substring(myController.selection.start);
              },
            ),
            MaterialButton(
              color: Colors.black12,
              child: Text('1.'),
              onPressed: () {
                myController.text = myController.text.substring(0, myController.selection.start)
                  + '1. '
                  + myController.text.substring(myController.selection.start);
              },
            ),
            MaterialButton(
              color: Colors.black12,
              child: Text('```'),
              onPressed: () {
                myController.text = myController.text.substring(0, myController.selection.start)
                  + '```\x0A' + myController.text.substring(myController.selection.start, myController.selection.end) + '\x0A```'
                  + myController.text.substring(myController.selection.end);
              },
            ),
            MaterialButton(
              color: Colors.black12,
              child: Text('URL'),
              onPressed: () {
                myController.text = myController.text.substring(0, myController.selection.start)
                  + 'url[](' + myController.text.substring(myController.selection.start, myController.selection.end) + ')'
                  + myController.text.substring(myController.selection.end);
              },
            ),
            MaterialButton(
              color: Colors.black12,
              child: Text('- - -'),
              onPressed: () {
                myController.text = myController.text.substring(0, myController.selection.start)
                  + '\x0A - - - \x0A'
                  + myController.text.substring(myController.selection.start);
              },
            ),
            MaterialButton(
              color: Colors.black12,
              child: Text('SPACE'),
              onPressed: () {
                myController.text = myController.text.substring(0, myController.selection.start)
                  + '  '
                  + myController.text.substring(myController.selection.start);
              },
            ),
          ],
        )
      ),
    ]);
  }
}
class MarkInput extends StatefulWidget {
  @override
  MarkInputState createState() => MarkInputState();
}
