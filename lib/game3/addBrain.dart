int lengthadd = AddBrain()._fields.length;
var indexQuestionShowed = 0;

class AddBrain {
  final _fields = [
    QuestionFills('...Jane and Alice sisters?', 'Are'),
    QuestionFills('...this car yours?', 'Is'),
    QuestionFills('...I in your way?', 'Am'),
    QuestionFills('...Maria John\'s sister?', 'Is'),
    QuestionFills('...you twenty-five years old?', 'Are'),
    QuestionFills('...the Smiths divorced?', 'Are'),
    QuestionFills('...this your new bicycle?', 'Is'),
    QuestionFills('They ... not Canadian.', 'Are'),
    QuestionFills('Jack ... interested in languages.', 'Is'),
    QuestionFills('Kids ... not at the playground.', 'Are'),
    QuestionFills('What ... your phone number?', 'Is'),
    QuestionFills('They ... at the office.', 'Are'),
    QuestionFills('He ... not from Italy.', 'Is'),
    QuestionFills('You ... a kind teacher.', 'Are'),
    QuestionFills('She ... at work', 'Is'),
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

class QuestionFills {
  final String title;
  final String answer;
  QuestionFills(this.title, this.answer);
}
