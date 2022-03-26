import 'dart:ui';

import 'package:flutter/material.dart';

import 'itemModel.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  List<ItemModel> items;
  List<ItemModel> items2;
  int length;

  int score;
  bool gameOver;
  bool isPressedValue = false;
  bool isPressedName = false;

  initGame() {
    gameOver = false;
    score = 0;
    items = [
      ItemModel(value: '10 + 10', name: '20'),
      ItemModel(value: '12^2', name: '144'),
      ItemModel(value: 'Michael', name: 'Faraday'),
      ItemModel(value: 'Elon', name: 'Musk'),
      ItemModel(value: '45+15', name: '60'),
      ItemModel(value: 'George', name: 'Washington'),
      ItemModel(value: 'Kazakhstan', name: 'Nur-Sultan'),
      ItemModel(value: '15+15+15', name: '45'),
      ItemModel(value: 'Snow', name: 'White'),
      ItemModel(value: 'England', name: 'Great Britain'),
      ItemModel(value: 'Language', name: 'C++'),
      ItemModel(value: 'Barack', name: 'Obama'),
      ItemModel(value: 'Ukraine', name: 'Kiev'),
      ItemModel(value: '20^2', name: '400'),
      ItemModel(value: 'Relativity', name: 'Einstein'),
    ];
    items2 = List<ItemModel>.from(items);
    length = items.length;
    items2.shuffle();
  }

  String first;
  String second;

  @override
  void initState() {
    super.initState();
    initGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Score:  '+'$score / $length'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: score == length
              ? Center(
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          initGame();
                        });
                      },
                      child: Text('Try Again', style: TextStyle(fontSize: 22),)),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: items
                          .asMap()
                          .map((i, item) => MapEntry(
                              i,
                              SizedBox(
                                width: 150,
                                child: ElevatedButton(
                                    onPressed: () {
                                      print(i);
                                      setState(() {
                                        first = item.value;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.cyan,
                                        textStyle: TextStyle(fontSize: 22)
                                        ),
                                    child: Text(item.value)),
                              )))
                          .values
                          .toList(),
                    ),
                    Column(
                      children: items2
                          .asMap()
                          .map((i, item) => MapEntry(
                              i,
                              SizedBox(
                                width: 150,
                                child: ElevatedButton(
                                    onPressed: () {
                                      print(i);
                                      setState(() {
                                        second = item.value;
                                        if (first == second) {
                                          items.remove(item);
                                          items2.remove(item);
                                          score++;
                                        }
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.redAccent,
                                        textStyle: TextStyle(fontSize: 20),),
                                    child: Text(item.name)),
                              )))
                          .values
                          .toList(),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
