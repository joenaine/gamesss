import 'package:flutter/material.dart';
import 'package:gamesss/game1/game1.dart';

import 'game/game.dart';
import 'game2/2game2.dart';
import 'game4/game4.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Bebas',
      ),
      home: Game(),
    );
  }
}
