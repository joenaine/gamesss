import 'game4question.dart';

int length = QuestionsBrain()._questions.length;

class QuestionsBrain {
  final _questions = [
    Game4Question('The earth is the fourth planet from the sun', false),
    Game4Question('The planet Venus has no moons', true),
    Game4Question('Jupiter is composed mostly of iron', false),
    Game4Question('The sun is a star of average size', true),
    Game4Question('A lunar eclipse occurs when the sun passes', false),
    Game4Question('Light travels in a straight line', true),
    Game4Question('The Mona Liza was stolen from the Louvre in 1911', true),
    Game4Question('There is no snow on Minecraft', false),
    Game4Question('People may sneeze or cough while sleeping deeply', false),
    Game4Question('The Los Angeles Lakers won the 2020 NBA Championship', true),
    Game4Question('The film Moneyball is based on a true story', true),
    Game4Question('A credit card and a debit card are the same', false),
    Game4Question('Ethereum is the second-largest cryptocurrency after Bitcoin', true),
    Game4Question('There are three rivers in Saudi Arabia', false),
    Game4Question('The Great Wall of China is visible from space', false),
  ];

  var _indexQuestionShowed = 0;
  var _endListReached = false;

  String getQuestionTitle() {
    return _questions[_indexQuestionShowed].title;
  }

  bool getAnswerOfQuestion() {
    return _questions[_indexQuestionShowed].answer;
  }

  void showNextQuestion() {
    if (_indexQuestionShowed < _questions.length - 1) {
      _indexQuestionShowed++;
      _endListReached = false;
    } else {
      _indexQuestionShowed = 0;
      _endListReached = true;
    }
  }

  bool checkEndOfList() {
    return _endListReached;
  }
}
