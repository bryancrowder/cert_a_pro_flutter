import 'dart:convert';
import 'package:cert_a_pro/providers/answer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../keys.dart';

enum QuestionType { selectAll, selectOne }

class Question with ChangeNotifier {
  final String id;
  final String certID;
  final String question;
  final QuestionType questionType;
  final List<Answer> answers;

  Question(
      {required this.id,
      required this.certID,
      required this.question,
      required this.questionType,
      required this.answers});
}

class QuestionAnswer with ChangeNotifier {
  final String id;
  final String questionID;
  final QuestionType questionType;
  final List<QuestionAnswer> questionAnswer;

  QuestionAnswer(
      {required this.id,
      required this.questionID,
      required this.questionType,
      required this.questionAnswer});
}

class Questions with ChangeNotifier {
  List<Question> _questions = [];

  List<Question> get items {
    return [..._questions];
  }

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  addQuestion(String question, String certID, List<Answer> answers,
      QuestionType type) async {
    String jsonAnswers = jsonEncode(answers.toList());
    try {
      await firebaseFirestore.collection("questions").add({
        "question": question,
        "certificationID": certID,
        "answers": jsonAnswers,
        "questionType": type.toString()
      }).then((value) => _questions.add(Question(
          id: value.id,
          certID: certID,
          question: question,
          questionType: type,
          answers: answers)));
      notifyListeners();
    } catch (exception) {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(const SnackBar(
        content: Text("Something went wrong..."),
        backgroundColor: Colors.red,
      ));
    }
  }

  deleteQuestion(String id) async {
    try {
      _questions.remove(_questions.firstWhere((e) => e.id == id));
      await firebaseFirestore.collection("questions").doc(id).delete();
      notifyListeners();
    } catch (exception) {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(const SnackBar(
        content: Text("Something went wrong..."),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> getQuestions(String certid) async {
    _questions = [];
    try {
      await firebaseFirestore
          .collection("questions")
          .where("certificationID", isEqualTo: certid)
          .get()
          .then((questions) {
        for (var question in questions.docs) {
          QuestionType test = QuestionType.values
              .byName(question["questionType"].split(".").last);
          _questions.add(Question(
            id: question.id,
            certID: question["certificationID"],
            answers: jsonDecode(question["answers"]).cast<Answer>(),
            questionType: test,
            question: question["question"],
          ));
        }
      });
      notifyListeners();
    } catch (exception) {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(const SnackBar(
        content: Text("Something went wrong..."),
        backgroundColor: Colors.red,
      ));
    }
  }

  List<Question> getQuestionsExams(id) {
    getQuestions(id);
    return _questions;
  }

  findQuestionByCertID(id, questions) {
    List<Question> questionsList = [];
    for (var i = 0; i < questions; i++) {
      if (_questions[i].certID == id) {
        questionsList.add(_questions[i]);
      }
    }
    return questionsList;
  }
}
