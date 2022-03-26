import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'game4QuestionBrain.dart';

class Game4 extends StatefulWidget {
  final QuestionsBrain questionsBrain = QuestionsBrain();
  @override
  _Game4State createState() => _Game4State();
}

class _Game4State extends State<Game4> {
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

  void checkAnswer(bool buttonValue) {
    if (buttonValue == widget.questionsBrain.getAnswerOfQuestion()) {
      addOkCheck();
      setState(() {
        total++;
      });
    } else {
      addWrongMark();
    }
    widget.questionsBrain.showNextQuestion();

    if (widget.questionsBrain.checkEndOfList()) {
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
            "Да",
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
            "Нет",
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

  Widget _createCustomButton(Color color, bool value, String key) {
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
          setState(() => checkAnswer(value));
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
          'SCORE: ' + "$total/$length",
          style: TextStyle(color: Colors.black, fontSize: 22),
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
                child: Column(
                  children: [
                    SizedBox(
                        height: 300,
                        width: 300,
                        child: Image.asset('assets/images/cat.png')),
                    Text(
                      widget.questionsBrain.getQuestionTitle(),
                      style: Theme.of(context).textTheme.headline5.copyWith(
                            color: Colors.indigo[700],
                          ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          ),
          _createCustomButton(Colors.green, true, 'TRUE'),
          _createCustomButton(Colors.redAccent, false, 'FALSE'),
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
