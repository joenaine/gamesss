import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'addBrain.dart';

class Game3 extends StatefulWidget {
  final AddBrain fieldsBrain = AddBrain();

  @override
  State<Game3> createState() => _Game3State();
}

class _Game3State extends State<Game3> {
  TextEditingController _editingController = new TextEditingController();
  bool isFocused = false;
  FocusNode _focusNode = new FocusNode();

  List<String> _feedbacks = [
    'Are',
    'Is',
    'Am',
  ];

  final List<Widget> score = [];
  int total = 0;

  void addOkCheck() {
    score.add(
      Icon(
        Icons.check,
        color: Colors.green,
      ),
    );
  }

  void addWrongMark() {
    score.add(
      Icon(
        Icons.close,
        color: Colors.red,
      ),
    );
  }

  void checkAnswer({String buttonValue}) {
    if (buttonValue == widget.fieldsBrain.getAnswerOfFields()) {
      addOkCheck();
      setState(() {
        total++;
      });
    } else {
      addWrongMark();
    }
    widget.fieldsBrain.showNextField();

    if (widget.fieldsBrain.checkEndOfField()) {
      showAlert();
    }
  }

  void showAlert() {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Game Over!",
      desc: "You`ve answered all questions. Do you want to go through again?",
      buttons: [
        DialogButton(
          child: Text(
            "Yes",
            style: Theme.of(context).textTheme.subtitle2,
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            setState(() {
              score.clear();
              total = 0;
            });
          },
          color: Colors.green,
        ),
        DialogButton(
          child: Text(
            "No",
            style: Theme.of(context).textTheme.subtitle2,
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          color: Colors.redAccent,
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          "$total/$lengthadd",
          style: TextStyle(fontSize: 32),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              child: Center(
                child: Text(
                  widget.fieldsBrain.getFieldsTitle(),
                  style: TextStyle(fontSize: 42),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: TextField(
              enabled: false,
              maxLines: 1,
              focusNode: _focusNode,
              controller: _editingController,
              cursorColor: Colors.black,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.indigo[700],
                fontSize: 42,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 32,
                    fontWeight: FontWeight.w500),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black, width: 5),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 20)),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 8.0,
              runSpacing: 8.0,
              children: _feedbacks
                  .asMap()
                  .map((i, item) => MapEntry(
                        i,
                        BouncingWidget(
                          duration: Duration(milliseconds: 100),
                          scaleFactor: 1.5,
                          onPressed: () {
                            _editingController.text = _feedbacks[i];
                            _focusNode.requestFocus();
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 20),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: Colors.grey.shade200, width: 2),
                            ),
                            child: Text(
                              _feedbacks[i],
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.grey.shade800, fontSize: 36),
                            ),
                          ),
                        ),
                      ))
                  .values
                  .toList(),
            ),
          ),
          SizedBox(
            height: 26,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: MaterialButton(
              onPressed: () {
                setState(() {
                  checkAnswer(buttonValue: _editingController.text);
                });
              },
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              color: Colors.black87,
              child: Text(
                'CHECK',
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
            ),
          ),
          /*TextButton(
              onPressed: () {
                setState(() {
                  checkAnswer(buttonValue: _editingController.text);
                });
              },
              child: Text(
                'CHECK',
                style: TextStyle(fontSize: 32),
              )),*/
          score.length != 0
              ? Container(
                  margin: EdgeInsets.only(
                      left: 16.0, bottom: 16.0, top: 8.0, right: 16.0),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: score,
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(bottom: 16.0),
                ),
        ],
      ),
    );
  }
}
