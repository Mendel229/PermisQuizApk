class Quiz {
  final String title;
  final String description;
  final List<Question> questions;

  Quiz({required this.title, required this.description, required this.questions});

  factory Quiz.fromJson(Map<String, dynamic> json) {
    var list = json['questions'] as List;
    List<Question> questionList = list.map((i) => Question.fromJson(i)).toList();

    return Quiz(
      title: json['title'],
      description: json['description'],
      questions: questionList,
    );
  }
}

class Question {
  final String question;
  final String imagePath;
  final List<Option> options;
  final String feedback;
  final String hint;
  final int answersindex;

  Question({required this.question, required this.imagePath, required this.options, required this.feedback, required this.hint, required this.answersindex});

  factory Question.fromJson(Map<String, dynamic> json) {
    var list = json['options'] as List;
    List<Option> optionList = list.map((i) => Option.fromJson(i)).toList();

    return Question(
      question: json['question'],
      imagePath: json['chemin'],
      options: optionList,
      feedback: json['feedback'],
      answersindex: json['answers_index'],
      hint: json['hint'],
    );
  }
}

class Option {
  final String text;
  final bool isCorrect;

  Option({required this.text, required this.isCorrect});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      text: json['text'],
      isCorrect: json['isCorrect'],
    );
  }
}