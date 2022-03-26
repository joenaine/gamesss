import 'question.dart';

int lengthfield = FieldsBrain()._fields.length;
var indexQuestionShowed = 0;

class FieldsBrain {
  final _fields = [
    QuestionFills('In which part of your body would you find the cruciate ligament?', 'knee'),
    QuestionFills('What is the name of the main antagonist in the Shakespeare play Othello?', 'Iago'),
    QuestionFills(
        'What is the smallest planet in our solar system?', 'Mercury'),
    QuestionFills('Which legendary surrealist artist is famous for painting melting clocks?', 'Salvador Dali'),
    QuestionFills('What was the Turkish city of Istanbul called before 1930?', 'Constantinople'),
    QuestionFills(
        'What is the currency of Denmark?', 'Krone'),
    QuestionFills(
        'Which popular video game franchise has released games with the subtitles World At War and Black Ops?', 'Call of Duty'),
    QuestionFills('What element is denoted by the chemical symbol Sn in the periodic table?', 'Tin'),
    QuestionFills('In which European country would you find the Rijksmuseum?', 'Netherlands'),
  ];

  var _endListReached = false;

  String getFieldsTitle() {
    return _fields[indexQuestionShowed].title;
  }

  String getAnswerOfFields() {
    return _fields[indexQuestionShowed].answer;
  }

  void showNextField() {
    if (indexQuestionShowed < _fields.length - 1) {
      indexQuestionShowed++;
      _endListReached = false;
    } else {
      indexQuestionShowed = 0;
      _endListReached = true;
    }
  }

  bool checkEndOfField() {
    return _endListReached;
  }
}
