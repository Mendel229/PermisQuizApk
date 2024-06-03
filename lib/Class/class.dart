class Quizz {
  final String title;
  final String description;
  final List<Questionn> questions;

  Quizz({required this.title, required this.description, required this.questions});

  factory Quizz.fromJson(Map<String, dynamic> json) {
    var list = json['questions'] as List;
    List<Questionn> questionList = list.map((i) => Questionn.fromJson(i)).toList();

    return Quizz(
      title: json['title'],
      description: json['description'],
      questions: questionList,
    );
  }
}

class Questionn {
  final String questionText;
  final String imagePath;
  final List<Optionn> options;
  final String feedback;
  final String hint;

  Questionn({required this.questionText, required this.imagePath, required this.options, required this.feedback, required this.hint});

  factory Questionn.fromJson(Map<String, dynamic> json) {
    var list = json['options'] as List;
    List<Optionn> optionList = list.map((i) => Optionn.fromJson(i)).toList();

    return Questionn(
      questionText: json['questionText']['text'],
      imagePath: json['questionText']['chemin'],
      options: optionList,
      feedback: json['feedback'],
      hint: json['hint'],
    );
  }
}

class Optionn {
  final String text;
  final bool isCorrect;

  Optionn({required this.text, required this.isCorrect});

  factory Optionn.fromJson(Map<String, dynamic> json) {
    return Optionn(
      text: json['text'],
      isCorrect: json['isCorrect'],
    );
  }
}
