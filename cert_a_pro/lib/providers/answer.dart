class Answer {
  final String answer;
  final bool correctAnswer;

  Answer({required this.answer, required this.correctAnswer});

        Answer.fromJson(Map<String, dynamic> json)
      : answer = json['answer'],
        correctAnswer = json['correctAnswer'];

  Map<String, dynamic> toJson() {
    return {
      'answer': answer,
      'correctAnswer': correctAnswer,
    };
  }
}


class QuestionAnswer {
  final String answer;
  final bool correctAnswer;

  QuestionAnswer({required this.answer, required this.correctAnswer});

        QuestionAnswer.fromJson(Map<String, dynamic> json)
      : answer = json['answer'],
        correctAnswer = json['correctAnswer'];

  Map<String, dynamic> toJson() {
    return {
      'answer': answer,
      'correctAnswer': correctAnswer,
    };
  }
}