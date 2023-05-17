import 'package:cert_a_pro/providers/question.dart';
import 'package:flutter/material.dart';

enum States { ready, inProgress, complete }

class Exam with ChangeNotifier {
  final String id;
  final String certID;
  final String title;
  final Enum state;
  final List<Question> questions;
  final List<QuestionAnswer> answers;

  Exam(
      {required this.id,
      required this.certID,
      required this.title,
      required this.questions,
      required this.answers,
      required this.state});
}

class Exams with ChangeNotifier {
  createExam(
      String title, String certID, int questions, List<Question> questionList) {
    final newExam = Exam(
        id: 'E1',
        certID: certID,
        questions: getQuestions(questionList, questions),
        answers: [],
        state: States.ready,
        title: title);

    return newExam;
  }

  List<Question> getQuestions(questions, questionCount) {
    List<Question> newOrder = [];
    questions.shuffle();
    for (var i = 0; i < questionCount; i++) {
      newOrder.add(questions[i]);
    }

    return newOrder;
  }
}
