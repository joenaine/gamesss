import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Game1 extends StatefulWidget {
  createState() => Game1State();
}

class Game1State extends State<Game1> {
  int navResult;
  final Map<String, bool> score = {};
  final Map choices = {
    '15+15+15': '45',
    'Michael': 'Faraday',
    'George': 'Washington',
    'Kazakhstan': 'Nur-Sultan',
    'Relativity': 'Einstein',
    'Planet': 'Mercury',
    'Subject': 'Physics',
  };

  int seed = 0;

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
              seed++;
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
            if (score.length == choices.length)
              setState(() {
                navResult = 1;
              });
            else
              setState(() {
                navResult = 0;
              });

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Score: ${score.length} / ${choices.length}',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            score.clear();
            seed++;
          });
        },
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: choices.keys.map((emoji) {
              return Draggable<String>(
                data: emoji,
                child: Emoji(emoji: score[emoji] == true ? '🚀' : emoji),
                feedback: Emoji(emoji: emoji),
                childWhenDragging: Emoji(emoji: '👀'),
              );
            }).toList(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                choices.keys.map((emoji) => _buildDragTarget(emoji)).toList()
                  ..shuffle(Random(seed)),
          )
        ],
      ),
    );
  }

  Widget _buildDragTarget(emoji) {
    return DragTarget<String>(
      builder: (BuildContext context, List<String> incoming, List rejected) {
        return score[emoji] == true
            ? Container(
                child: Text(
                  'GOOD!',
                  style: TextStyle(fontSize: 22, color: Colors.green),
                ),
                alignment: Alignment.center,
                height: 80,
                width: 200,
              )
            : Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue.shade200, width: 2),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    choices[emoji],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                height: 80,
                width: 200);
      },
      onWillAccept: (data) => data == emoji,
      onAccept: (data) {
        setState(() {
          score[emoji] = true;
        });
        if (score.length == choices.length) {
          showAlert();
        }
      },
      onLeave: (data) {},
    );
  }
}

class Emoji extends StatelessWidget {
  Emoji({Key key, @required this.emoji}) : super(key: key);

  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: 80,
        width: 120,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black54, width: 2),
            borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Text(
          emoji,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
