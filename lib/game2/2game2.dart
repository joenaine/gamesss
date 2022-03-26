import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'fieldBrain.dart';

class Game2Unit2 extends StatefulWidget {
  final FieldsBrain fieldsBrain = FieldsBrain();
  @override
  _Game2Unit2State createState() => _Game2Unit2State();
}

class _Game2Unit2State extends State<Game2Unit2> {
  List<TextEditingController> _controller =
      List.generate(9, (i) => TextEditingController());

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

  Container _textField(int i) {
    return Container(
      height: 70,
      width: 300,
      child: TextField(
        controller: _controller[i],
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                _controller[i].clear();
              },
              icon: Icon(Icons.cancel),
              color: Theme.of(context).primaryColor,
            ),
            alignLabelWithHint: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.black, width: 1),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            labelStyle: TextStyle(fontSize: 18)),
        style: TextStyle(fontSize: 26, color: Colors.black),
      ),
    );
  }

  Widget _createCustomButton(Color color, String value, String key) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: RaisedButton(
        color: color,
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Text(
          key,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(color: Colors.grey[300]),
        ),
        onPressed: () {
          setState(() => checkAnswer(buttonValue: value));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          'Score: ' + "$total/$lengthfield",
          style: TextStyle(
              color: Colors.indigo[700],
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              child: Center(
                child: Text(
                  widget.fieldsBrain.getFieldsTitle(),
                  style: Theme.of(context).textTheme.headline5.copyWith(
                        color: Colors.indigo[700],
                      ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
          _textField(indexQuestionShowed),
          TextButton(
              onPressed: () {
                setState(() {
                  checkAnswer(
                      buttonValue: _controller[indexQuestionShowed].text);
                });
              },
              child: Text(
                'SUBMIT',
                style: TextStyle(fontSize: 22),
              )),
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
